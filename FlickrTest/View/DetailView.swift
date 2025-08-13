//
//  DetailView.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 13..
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss

    let photo: FlickrResponse.Photo
    
    var body: some View {
        ZStack(alignment: .top) {
            // Fő tartalom – egyszerű, tiszta Image
            Color.clear.ignoresSafeArea()
            ImageTunerView(photo: photo)
            
            GeometryReader { geo in
                let safeTop = geo.safeAreaInsets.top
                let navBarHeight: CGFloat = 44 // standard iOS nav bar magasság
                
                ZStack(alignment: .leading) {
                    // thinMaterial háttér a back gomb mögé
                    Color.clear
                        .frame(height: safeTop + navBarHeight)
                        .background(.thinMaterial)
                    
                    // back gomb
                    Button(action: { dismiss() } ) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                    .padding(.top, 50)
                    .padding(.leading, 20)
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .ignoresSafeArea(edges: .top)
            }
            }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailView(
        photo: FlickrResponse.Photo(
            id: "54718138489",
            secret: "4bd70e3925",
            server: "65535",
            farm: 66,
            title: "Walking the Dog"
        )
    )
}
