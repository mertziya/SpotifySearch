//
//  Song.swift
//  RESTfulService
//
//  Created by Mert Ziya on 7.01.2025.
//

import Foundation

struct Song: Codable {
    let songName: String
    let mainArtistName: String
    let albumName: String
    let albumImg: String
    let featuringArtistNames: [String]
    let popularity: Int
    let duration_ms: Int
    let release_date: String
    let artistId: String
}

struct DataContainer: Codable {
    let songsArray: [Song] // Not optional, since "songsArray" is always present in the response
    let success: Bool
}
