//
//  DataTrendingModel.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation


// MARK: - DataTrendingModel
struct DataTrendingModel: Codable, Identifiable {
    let type: TypeEnum
    let id: String
    let url: String
    let slug: String
    let bitlyGIFURL, bitlyURL: String
    let embedURL: String
    let username: String
    let source: String
    let title: String
    let rating: Rating
    let contentURL, sourceTLD: String
    let sourcePostURL: String
    let isSticker: Int
    let importDatetime, trendingDatetime: String
    let images: ImagesModel
    let user: UserModel?
    let analyticsResponsePayload: String
    let analytics: AnalyticsModel

    enum CodingKeys: String, CodingKey {
        case type, id, url, slug
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username, source, title, rating
        case contentURL = "content_url"
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, user
        case analyticsResponsePayload = "analytics_response_payload"
        case analytics
    }
}
