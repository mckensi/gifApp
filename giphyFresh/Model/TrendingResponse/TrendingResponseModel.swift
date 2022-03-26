//
//  TrendingResponseModel.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation

// MARK: - Welcome
struct TrendingResponseModel: Codable {
    let data: [DataTrendingModel]
    let pagination: PaginationModel
    let meta: Meta
}
