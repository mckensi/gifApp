//
//  GifViewModel.swift
//  giphyFresh
//
//  Created by Daniel Steven Murcia Almanza on 27/03/22.
//

import Foundation

final class GifViewModel : ObservableObject {
    private var favoriteLocalDataSource = FavoriteGifLocalDataSource()
    var gif : DataTrendingModel
    @Published var isFavorite: Bool
    
    init(gif : DataTrendingModel) {
        self.gif = gif
        self.isFavorite = favoriteLocalDataSource.isFavorite(gif: gif)
    }
     

    
    func selectHeartAction() {
        self.isFavorite.toggle()
        isFavorite ? addFavorite() : removeFavorite()
    }
    
    private func addFavorite() {
        favoriteLocalDataSource.addNewFavoriteGif(gif: self.gif)
    }
    
    private func removeFavorite() {
        favoriteLocalDataSource.removeFavoriteGif(gif: self.gif)
    }
    
    func updateFavorite() {
        isFavorite = favoriteLocalDataSource.isFavorite(gif: self.gif)
    }
}
