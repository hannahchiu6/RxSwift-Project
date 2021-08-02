//
//  Model.swift
//  RxSwift-Practice
//
//  Created by Hannah.C on 01.08.21.
//

import Foundation
import UIKit

// MARK: KKBox Token
struct AccessTokenResponse: Codable {
    var accessToken: String
    var expiresIn: Int
    var tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }

}

// MARK: - KkboxObject
struct SongData: Codable {
    let data: [Song]
    var paging: Paging
    var summary: Summary
}

// MARK: - Datum
struct Song: Codable {
    let id, name: String
    let duration: Int
    let isrc: String
    let url: String
    let trackNumber: Int
    let explicitness: Bool
    let availableTerritories: [AvailableTerritory]
    let album: Album

    enum CodingKeys: String, CodingKey {
        case id, name, duration, isrc, url
        case trackNumber = "track_number"
        case explicitness
        case availableTerritories = "available_territories"
        case album
    }
}

struct Album: Codable {
    var id: String
    var name: String
    var url: String
    var images: [Image]
    var artist: Artist

    enum CodingKeys: String, CodingKey {
        case id, name, url, images, artist
    }
}

struct Artist: Codable {
    var id: String
    var name: String
    var url: String
    var images: [Image]
}

struct Image: Codable {
//    var height: Int
//    var width: Int
    var url: String
}


struct Summary: Codable {
    let total: Int
}

enum AvailableTerritory: String, Codable {
    case hk = "HK"
    case jp = "JP"
    case my = "MY"
    case sg = "SG"
    case tw = "TW"
}

//MARK: - Paging
struct Paging: Codable {
  let offset: Int
  let limit: Int
  let next: String?
}

