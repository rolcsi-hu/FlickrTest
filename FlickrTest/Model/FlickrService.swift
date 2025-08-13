//
//  FlickrService.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 12..
//

import Foundation


struct FlickrService {
    private let apiKey = "65803e8f6e4a3982200621cad356be51"
    private let rootURL = "https://api.flickr.com/services/rest/"

    func search(for text: String, page:Int = 1) async throws -> FlickrResponse {
        guard let url = URL(string: "\(rootURL)?method=flickr.photos.search&api_key=\(apiKey)&text=\(text)&format=json&nojsoncallback=1&per_page=20&page=\(page)")
        else { throw FlickrError.invalidURL(text) }

        guard let (data, response) = try? await URLSession.shared.data(from: url)
        else { throw FlickrError.connectionFailed }

        print("Data: \(String(data: data, encoding: String.Encoding.utf8) ?? "Invalid »»JSON««")")
        print("Response: \(response)")
        guard let httpResponse = response as? HTTPURLResponse
        else { throw FlickrError.unknown }

        if httpResponse.statusCode != 200 {
            throw FlickrError.requestFailed(statusCode: httpResponse.statusCode)
        }

        guard let result = try? JSONDecoder().decode(FlickrResponse.self, from: data)
        else { throw FlickrError.decodingFailed }
        
        return result
    }

}
