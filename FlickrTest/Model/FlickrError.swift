//
//  FlickrError.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 12..
//

import Foundation

enum FlickrError: Error, LocalizedError {
    case invalidURL(String)
    case connectionFailed
    case requestFailed(statusCode: Int)
    case decodingFailed
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL(let keyword):
            return "Invalid URL for keyword \(keyword)."
        case .requestFailed(let statusCode):
            return "Request failed. HTTP status code \(statusCode)."
        case .decodingFailed:
            return "Decoding of response failed."
        case .connectionFailed:
            return "Connection failed."
        case .unknown:
            return "Unknown error."
        }
    }
}
