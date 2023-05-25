//
//  ComicDataWrapper.swift
//  MVP_Project
//
//  Created by Aleksei on 23.05.2023.
//

import Foundation

struct ComicDataWrapper: Codable {
    let status: String?
    let data: ComicDataContainer?
}

struct ComicDataContainer: Codable {
    let results: [Comic]?
}

struct Comic: Codable {
    let id: Int?
    let digitalId: Int?
    let title: String?
    let thumbnail: Thumbnail?
}

extension Comic {
    struct Thumbnail: Codable {
        let path: String
        let pathExtension: String
        
        enum CodingKeys: String, CodingKey {
            case path
            case pathExtension = "extension"
        }
    }
}
