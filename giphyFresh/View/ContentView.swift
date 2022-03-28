//
//  ContentView.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = GifMainViewModel()
    var favoriteLocalDataSource = FavoriteGifLocalDataSource()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.gifs) { gif in
    
                    ZStack {
                        GIFImageTest(
                            viewModel: GifViewModel(gif: gif)
                        )
                    }
                }
            }
            .navigationTitle("GIFS")
            .onAppear {
                viewModel.getGifPublisher()
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            if(newValue.isEmpty) {
                viewModel.getGifPublisher()
            } else {
                viewModel.searchGifs(search: newValue)
            }
     
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
