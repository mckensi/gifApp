//
//  NetworkManagerMock.swift
//  giphyFreshTests
//
//  Created by Daniel Steven Murcia Almanza on 28/03/22.
//

import Foundation
import Combine
import SwiftUI
@testable import giphyFresh

struct NetworkManagerMock : DataProvider {
    
    
    let dataTrending = [
        DataTrendingModel(type: nil, id: "1", url: nil, slug: nil, bitlyGIFURL: nil, bitlyURL: nil, embedURL: nil, username: nil, source: nil, title: nil, rating: nil, contentURL: nil, sourceTLD: nil, sourcePostURL: nil, isSticker: nil, importDatetime: nil, trendingDatetime: nil, images: nil, user: nil, analyticsResponsePayload: nil, analytics: nil),
        DataTrendingModel(type: nil, id: "2", url: nil, slug: nil, bitlyGIFURL: nil, bitlyURL: nil, embedURL: nil, username: nil, source: nil, title: nil, rating: nil, contentURL: nil, sourceTLD: nil, sourcePostURL: nil, isSticker: nil, importDatetime: nil, trendingDatetime: nil, images: nil, user: nil, analyticsResponsePayload: nil, analytics: nil),
        DataTrendingModel(type: nil, id: "3", url: nil, slug: nil, bitlyGIFURL: nil, bitlyURL: nil, embedURL: nil, username: nil, source: nil, title: nil, rating: nil, contentURL: nil, sourceTLD: nil, sourcePostURL: nil, isSticker: nil, importDatetime: nil, trendingDatetime: nil, images: nil, user: nil, analyticsResponsePayload: nil, analytics: nil)
    ]
    
    func getGifPublisher() -> AnyPublisher<Data, Error> {
        var data: Data?
        let trendingRes = TrendingResponseModel(
            data: dataTrending,
            pagination: nil,
            meta: nil
        )
        let encoder = JSONEncoder()
        do {
            data = try encoder.encode(trendingRes)
            return Just(data!)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Just(data!)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func searchGifs(search: String) -> AnyPublisher<Data, Error> {
        var data: Data?
        let trendingRes = TrendingResponseModel(data: dataTrending, pagination: nil, meta: nil)
        let encoder = JSONEncoder()
        do {
            data = try encoder.encode(trendingRes)
            return Just(data!)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Just(data!)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
            
    }
    
}
