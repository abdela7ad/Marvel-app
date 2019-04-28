//
//  CharachterModel.swift
//  MarvelApp
//
//  Created by Abdelahad on 4/28/19.
//  Copyright © 2019 Abdelahad. All rights reserved.
//

import Foundation


struct Item: Codable {
    let resourceURI: String
    let name: String
}
struct Category: Decodable {
    let available: Int
    let items: [Item]
}

struct CharacterItems: Decodable {
    let offset, limit, total, count: Int
    let results: [CharacterItem]
}
struct CharacterItem: Decodable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let comics, series,event,stories: Category?
    let urls: [URLElement]
}


struct Thumbnail: Decodable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}



struct URLElement: Decodable {
    let type: URLType
    let url: String
}

enum URLType: String, Decodable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}


