//
//  ThumbnailView.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 13..
//

import SwiftUI

struct ThumbnailView: View {
    var photo: FlickrResponse.Photo

    var body: some View {
        VStack {
            
            // MARK: Async Image
            
            AsyncImage(url: URL(string: photo.thumbnailUrl)) { phase in
                switch phase {

                case .empty:
                    ZStack {
                        Color.clear.scaledToFill()
                        ProgressView()
                    }
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(8)
                case .failure(let error):
                    Text("Error: \(error)")
                @unknown default:
                    Text("IDK what happened")
                }
            }
                .scaledToFit()

            // MARK: Text

            Text(photo.title)
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.horizontal, 4)
        }
    }
}

// MARK: Preview

#Preview {
    ThumbnailView(
        photo: FlickrResponse.Photo(
            id: "54718138489",
            secret: "4bd70e3925",
            server: "65535",
            farm: 66,
            title: "Walking the Dog"
        )
    )
}
