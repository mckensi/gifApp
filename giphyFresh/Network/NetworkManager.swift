//
//  GiphyNetwork.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation
import Combine

enum NetworkErrors: Error {
    case general(String)
    case timeout(String)
    case notFound(String)
    case badConnection(String)
}

var subscribers = Set<AnyCancellable>()

let url = URL(string: "https://api.giphy.com/v1/gifs/trending")!


final class NetworkManager: ObservableObject {
    
    @Published var responseTrending: TrendingResponseModel?
    
    func getTrendingGif() -> TrendingResponseModel? {
        var responseFromNetwork: TrendingResponseModel?
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error -> NetworkErrors in
                if error.errorCode == -1001 {
                    return .timeout(error.localizedDescription)
                } else {
                    return .general(error.localizedDescription)
                }
                
            }
            .retry(3)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkErrors.badConnection("Error on Network conection")
                }
                if response.statusCode == 200 {
                    return data
                } else {
                    throw NetworkErrors.notFound("Status code \(response.statusCode)")
                }
            }
            .decode(type: TrendingResponseModel.self, decoder: JSONDecoder())
            .sink { completion in
                if case .failure(let error) = completion,
                   let networkErr = error as? NetworkErrors {
                    switch networkErr {
                    case .general(let message):
                        print("General error \(message)")
                    case .timeout(let message):
                        print("Timeout error \(message)")
                    case .notFound(let message):
                        print("NotFound error \(message)")
                    case .badConnection(let message):
                        print("Bad connection error \(message)")
                    }
                }
            } receiveValue: { response in
                responseFromNetwork = response
            }
        return responseFromNetwork
    }
}

