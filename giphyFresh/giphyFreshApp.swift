//
//  giphyFreshApp.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import SwiftUI

@main
struct giphyFreshApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
