//
//  SearchFieldView.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 11..
//

import SwiftUI

struct SearchField: View {
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Keresés...", text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 8)
            .padding(.horizontal)
        }
        .padding(.bottom, 4)
        .background(.thinMaterial)
        .frame(maxWidth: .infinity)
    }
}

#Preview("Default: dog") {
    SearchField(text: .constant("dog"))
    Spacer()
}

#Preview("Empty dark") {
    SearchField(text: .constant(""))
        .preferredColorScheme(.dark)
    Spacer()
}

#Preview("Long text") {
    SearchField(text: .constant("this is a very long keyword you can search for"))
    Spacer()
}
