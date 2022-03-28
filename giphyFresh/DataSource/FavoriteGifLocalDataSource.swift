//
//  FavoriteGifLocalDataSource.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation

class FavoriteGifLocalDataSource {
    var defaults = UserDefaults.standard
    
    /// Add new favorite item into user defaults
    func addNewFavoriteGif(gif: DataTrendingModel) {
        var favorites : [DataTrendingModel] = getFavoriteGifs()
        favorites.append(gif)
        do {
            try defaults.setObject(favorites, forKey: "favorite")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Get all the favorite gifs from user defaults
    func getFavoriteGifs() -> [DataTrendingModel]{
        var favorites : [DataTrendingModel] = []
        do {
            favorites = try defaults.getObject(forKey: "favorite", castTo: [DataTrendingModel].self)
            print(favorites)
        } catch {
            print(error.localizedDescription)
        }
        return favorites
    }
    
    ///  Returns if some gif is selected like a favorite before
    func isFavorite(gif: DataTrendingModel) -> Bool {
        let favorites = getFavoriteGifs()
        return favorites.contains { $0.id == gif.id}
    }
    
    /// Remove some favorite gif from user defaults
    func removeFavoriteGif(gif: DataTrendingModel) {
        var favorites : [DataTrendingModel] = getFavoriteGifs()
        favorites.removeAll { $0.id == gif.id}
        do {
            try defaults.setObject(favorites, forKey: "favorite")
        } catch {
            print(error.localizedDescription)
        }
    }
}
