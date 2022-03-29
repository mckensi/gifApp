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

struct NetworkManager: DataProvider {
    
    var subscribers = Set<AnyCancellable>()
    
    /// Get gifs from API Giphy
    func getGifPublisher() -> AnyPublisher<Data, Error> {
        var urlGifTrending = URLComponents(string: "https://api.giphy.com/v1/gifs/trending")!
        urlGifTrending.queryItems = [
            URLQueryItem(name: "api_key", value: "dVO4smhMOrhvgKDC5JaPSFfYseBfANaX"),
            URLQueryItem(name: "limit", value: "10")
        ]
        let request = URLRequest(url: urlGifTrending.url!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
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
            }.eraseToAnyPublisher()
            
    }
    
    /// Search gifs from API Giphy
    func searchGifs(search: String) -> AnyPublisher<Data, Error>{
        var urlGifTrending = URLComponents(string: "https://api.giphy.com/v1/gifs/search")!
        urlGifTrending.queryItems = [
            URLQueryItem(name: "api_key", value: "dVO4smhMOrhvgKDC5JaPSFfYseBfANaX"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "q", value: search)
        ]
        
        let request = URLRequest(url: urlGifTrending.url!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
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
            .eraseToAnyPublisher()
    }
}
