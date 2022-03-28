//
//  ImagesModel.swift
//  giphyFresh
//
//  Created by Daniel Murcia Almanza on 25/03/22.
//

import Foundation

// MARK: - Images
struct ImagesModel: Codable {
    let original: FixedHeight?
    let downsized, downsizedLarge, downsizedMedium: The480_WStill?
    let downsizedSmall: The4_K?
    let downsizedStill: The480_WStill?
    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: FixedHeight?
    let fixedHeightSmallStill, fixedHeightStill: The480_WStill?
    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: FixedHeight?
    let fixedWidthSmallStill, fixedWidthStill: The480_WStill?
    let looping: Looping?
    let originalStill: The480_WStill?
    let originalMp4, preview: The4_K?
    let previewGIF, previewWebp, the480WStill: The480_WStill?
    let hd, the4K: The4_K?

    enum CodingKeys: String, CodingKey {
        case original, downsized
        case downsizedLarge = "downsized_large"
        case downsizedMedium = "downsized_medium"
        case downsizedSmall = "downsized_small"
        case downsizedStill = "downsized_still"
        case fixedHeight = "fixed_height"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case fixedHeightStill = "fixed_height_still"
        case fixedWidth = "fixed_width"
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidthSmall = "fixed_width_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedWidthStill = "fixed_width_still"
        case looping
        case originalStill = "original_still"
        case originalMp4 = "original_mp4"
        case preview
        case previewGIF = "preview_gif"
        case previewWebp = "preview_webp"
        case the480WStill = "480w_still"
        case hd
        case the4K = "4k"
    }
}
