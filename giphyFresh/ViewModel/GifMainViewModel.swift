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
    
    var networkManager : DataProvider
    
    init(networkManager: DataProvider = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Get gifs from API Giphy using networkManager
    func getGifUsingNetworkManager() {
        networkManager.getGifPublisher()
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
    
    /// Search gifs from API Giphy using networkManager
    func searchGifsNetworkManager(search: String) {
        networkManager.searchGifs(search: search)
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
