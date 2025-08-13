//
//  FlickrResponse.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 11..
//

import Foundation

struct FlickrResponse:Codable {

    // MARK: Photo struct definition

    struct Photo: Codable, Identifiable, Equatable, Hashable {
        let id: String
        let secret: String
        let server: String
        let farm: Int
        let title: String

        //"https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_q.jpg"
        var largeUrl: String {
            "https://live.staticflickr.com/\(server)/\(id)_\(secret)_b.jpg"
        }

        var thumbnailUrl: String {
            "https://live.staticflickr.com/\(server)/\(id)_\(secret)_q.jpg"
        }
    }

    // MARK: Photos struct definition

    struct Photos: Codable {
        let photo: [Photo]
        let page: Int
        let pages: Int
    }

    // MARK: self properties
    
    let photos: Photos
}
