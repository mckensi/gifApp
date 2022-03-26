//
//  MainView.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label {
                        Text("Gifs")
                    } icon: {
                        Image(systemName: "magnifyingglass")
                    }

                }
            FavoriteView()
                .tabItem {
                    Label {
                        Text("Favorites")
                    } icon: {
                        Image(systemName: "heart")
                    }

                }
        }
    }
    
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

