//
//  MasterViewModel.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 11..
//

import SwiftUI
import Combine


@MainActor
class MasterViewModel:ObservableObject {
    @AppStorage("searchText") var storedSearchText: String = "dog"

    @Published var searchText: String = ""
    {
        didSet { storedSearchText = searchText }
    }
    @Published var photos:[FlickrResponse.Photo] = []

    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>? = nil

    private let flickr = FlickrService()
    
    private var pages:Int = 1
    private var nextPage:Int { Int(ceil(Double(self.photos.count) / 20) + 1) }

    init() {
        self.searchText = self.storedSearchText

        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { searchText in searchText.count >= 3 }
            .sink { [weak self] searchText in
                
                guard let self = self
                else { return }
                
                self.searchTask?.cancel()
                self.searchTask = Task { await self.loadNext(reset: true) }
            }
            .store(in: &cancellables)
    }
    
    func loadNext(reset:Bool = false) async {
        if reset { self.photos = [] }
        
        guard pages >= nextPage else { return }

        guard let result = try? await self.flickr.search(for: searchText, page: self.nextPage)
        else { return }
        
        self.pages = result.photos.pages
        self.photos += result.photos.photo
    }
}
