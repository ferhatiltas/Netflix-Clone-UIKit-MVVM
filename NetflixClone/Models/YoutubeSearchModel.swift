//
//  YoutubeSearchModel.swift
//  NetflixClone
//
//  Created by ferhatiltas on 21.03.2022.
//

import Foundation

struct YoutubeSearchModel: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
