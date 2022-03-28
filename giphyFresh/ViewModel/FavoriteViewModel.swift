//
//  FavoriteViewModel.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation
import Combine
import SwiftUI

final class FavoriteViewModel : ObservableObject {
    
    @Published var favoriteGif: [DataTrendingModel] = []
    
    let favoriteGifDataSource = FavoriteGifLocalDataSource()
    
    /// Get favorite gifs from  localdatasource
    func getFavoriteGifs() {
        favoriteGif = favoriteGifDataSource.getFavoriteGifs()
    }
    
}
