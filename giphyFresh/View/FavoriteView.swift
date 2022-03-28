//
//  FavoriteView.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = FavoriteViewModel()
    @State var isOnGridView = false
    var favoriteLocalDataSource = FavoriteGifLocalDataSource()
    
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            if(!isOnGridView) {
                List {
                    ForEach(viewModel.favoriteGif) { gif in
                        GIFImageTest(
                            viewModel: GifViewModel(gif: gif)
                        )
                    }
                }
                .navigationBarTitle("Favorites")
                .navigationBarItems(
                    trailing: Button(
                        action: {
                            self.isOnGridView = !self.isOnGridView
                        },
                        label: {
                            Text(self.isOnGridView ? "List" : "Grid")
                        }
                    )
                )
            } else {
                ScrollView {
                    LazyVGrid(columns: threeColumnGrid) {
                        ForEach(viewModel.favoriteGif) { gif in
                            GIFImageTest(viewModel: GifViewModel(gif: gif))
                        }
                    }
                    .navigationBarTitle("Favorites")
                    .navigationBarItems(
                        trailing: Button(
                            action: {
                                self.isOnGridView = !self.isOnGridView
                            },
                            label: {
                                Text(self.isOnGridView ? "List" : "Grid")
                            }
                        )
                    )
                }
            }
      
        }.onAppear {
            viewModel.getFavoriteGifs()
        }
    }
    
}



struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

