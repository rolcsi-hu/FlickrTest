//
//  ContentView.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 10..
//

import SwiftUI

struct MasterView: View {

    @StateObject private var viewModel = MasterViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView {
                    Color.clear
                        .frame(height: 50)
                        .id("TOP")
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.photos) { photo in
                            NavigationLink(value: photo) {
                                ThumbnailView(photo: photo)
                                    .onAppear {
                                        if photo == viewModel.photos.last {
                                            Task { await viewModel.loadNext() }
                                        }
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationDestination(for: FlickrResponse.Photo.self) { photo in
                    DetailView(photo: photo)
                }

                SearchField(text: $viewModel.searchText)
            }
        }
    }
}

#Preview {
    MasterView()
}
