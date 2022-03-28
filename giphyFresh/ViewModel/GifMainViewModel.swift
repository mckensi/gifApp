//
//  GiphyMainViewModel.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation
import Combine
import SwiftUI

final class GifMainViewModel : ObservableObject {
    
    @Published var gifs: [DataTrendingModel] = []
    
    var subscribers = Set<AnyCancellable>()

    func getGifPublisher() {
        var urlGifTrending = URLComponents(string: "https://api.giphy.com/v1/gifs/trending")!
        urlGifTrending.queryItems = [
            URLQueryItem(name: "api_key", value: "dVO4smhMOrhvgKDC5JaPSFfYseBfANaX"),
            URLQueryItem(name: "limit", value: "10")
        ]
        let request = URLRequest(url: urlGifTrending.url!)
        
        URLSession.shared.dataTaskPublisher(for: request)
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
                DispatchQueue.main.async {
                    self.gifs = response.data ?? []
                }
            }
            .store(in: &self.subscribers)
    }
    
    
    func searchGifs(search: String) {
        var urlGifTrending = URLComponents(string: "https://api.giphy.com/v1/gifs/search")!
        urlGifTrending.queryItems = [
            URLQueryItem(name: "api_key", value: "dVO4smhMOrhvgKDC5JaPSFfYseBfANaX"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "q", value: search)
        ]
        
        let request = URLRequest(url: urlGifTrending.url!)
        
        URLSession.shared.dataTaskPublisher(for: request)
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
                DispatchQueue.main.async {
                    self.gifs = response.data ?? []
                }
            }
            .store(in: &self.subscribers)
    }
}
