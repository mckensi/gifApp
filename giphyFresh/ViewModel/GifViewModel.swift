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
    
    /// Add favorite gif into local datasource
    private func addFavorite() {
        favoriteLocalDataSource.addNewFavoriteGif(gif: self.gif)
    }
    
    /// Remove favorite gif into local datasource
    private func removeFavorite() {
        favoriteLocalDataSource.removeFavoriteGif(gif: self.gif)
    }
    
    /// Select  heart  action to change the view and remove or add favorite into local datasource
    func selectHeartAction() {
        self.isFavorite.toggle()
        isFavorite ? addFavorite() : removeFavorite()
    }
    
}
