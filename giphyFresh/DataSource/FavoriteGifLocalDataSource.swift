//
//  FavoriteGifLocalDataSource.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation

class FavoriteGifLocalDataSource {
    var defaults = UserDefaults.standard
    
    func addNewFavoriteGif(gif: DataTrendingModel) {
        var favorites : [DataTrendingModel] = getFavoriteGifs()
        favorites.append(gif)
        do {
            try defaults.setObject(favorites, forKey: "favorite")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeFavoriteGif(gif: DataTrendingModel) {
        var favorites : [DataTrendingModel] = getFavoriteGifs()
        favorites.removeAll { $0.id == gif.id}
        do {
            try defaults.setObject(favorites, forKey: "favorite")
        } catch {
            print(error.localizedDescription)
        }
    }

    
    func isFavorite(gif: DataTrendingModel) -> Bool {
        let favorites = getFavoriteGifs()
        return favorites.contains { $0.id == gif.id}
    }
    
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
}
