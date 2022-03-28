//
//  GifView.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation
import SwiftUI
import WebKit

struct GIFImageTest: View {
    
    @State private var imageData: Data? = nil
    
    @ObservedObject var viewModel : GifViewModel

    var body: some View {
        VStack {
            if let data = imageData {
                ZStack {
                    GIFImage(data: data)
                        .frame(width: 100, height: 100)
                    HStack {
                        Spacer()
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .onTapGesture {
                                viewModel.selectHeartAction()
                            }
                    }
                }
            } else {
                Text("Loading...")
                    .onAppear(perform: loadData)
            }
        }
    }
    
    private func loadData() {
        let task = URLSession.shared.dataTask(with: URL(string: viewModel.gif.images?.fixedHeight?.url ?? "")!) { data, response, error in
            imageData = data
        }
        task.resume()
    }
}
