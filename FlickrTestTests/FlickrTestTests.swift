//
//  FlickrTestTests.swift
//  FlickrTestTests
//
//  Created by Kovács Roland on 2025. 08. 10..
//

import Testing
@testable import FlickrTest

struct FlickrTestTests {
    
    @MainActor @Test("searchText retreived from AppStorage") func testInitSearchText() {
        let viewModel = MasterViewModel()
        #expect(viewModel.searchText == viewModel.storedSearchText)
    }
    
    
    
}
