//
//  DataProvider.swift
//  giphyFresh
//
//  Created by Daniel Steven Murcia Almanza on 28/03/22.
//

import Foundation
import Combine

protocol DataProvider {
    func getGifPublisher() -> AnyPublisher<Data, Error>
    func searchGifs(search: String) -> AnyPublisher<Data, Error>
}
