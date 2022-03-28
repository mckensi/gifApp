//
//  giphyFreshTests.swift
//  giphyFreshTests
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import XCTest
import Combine
@testable import giphyFresh

class giphyFreshTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    override func tearDown() {
        subscriptions = []
    }
    
    func testLoadingGifs() {
        let mock = NetworkManagerMock()
        let gifMainViewModel = GifMainViewModel(networkManager: mock)
        gifMainViewModel.getGifUsingNetworkManager()
        XCTAssertEqual(gifMainViewModel.gifs.count, 0)
        
        let promise = expectation(description: "loading 3 gifs")
    
        
        gifMainViewModel.$gifs.sink { (completion) in
            XCTFail()
        } receiveValue: { gifs in
            if(gifs.count == 3) {
                promise.fulfill()
            }
        }.store(in: &subscriptions)


        wait(for: [promise]	, timeout: 1)

    }
    
    func testSearhcGifs() {
        let mock = NetworkManagerMock()
        let gifMainViewModel = GifMainViewModel(networkManager: mock)
        gifMainViewModel.searchGifsNetworkManager(search: "wait")
        XCTAssertEqual(gifMainViewModel.gifs.count, 0)
        
        let promise = expectation(description: "loading 3 gifs")
    
        
        gifMainViewModel.$gifs.sink { (completion) in
            XCTFail()
        } receiveValue: { gifs in
            if(gifs.count == 3) {
                promise.fulfill()
            }
        }.store(in: &subscriptions)

        wait(for: [promise]    , timeout: 1)

    }
}
