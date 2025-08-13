//
//  ZoomDragImageView.swift
//  FlickrTest
//
//  Created by Kovács Roland on 2025. 08. 13..
//

import SwiftUI

struct ImageTunerView: View {

    let photo: FlickrResponse.Photo
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    @State private var pinchStartCenter: CGPoint? = nil
    
    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 8.0
    

    // MARK: Tuner Image View

    
    var body: some View {
        GeometryReader { geo in
            AsyncImage(url: URL(string: photo.largeUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.thinMaterial)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(tunerGesture(in: geo.size))
                    
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                    
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.black)
        }
        .ignoresSafeArea()
    }

    
    // MARK: tuner gesture


    private func tunerGesture(in size: CGSize) -> some Gesture {
        SimultaneousGesture(
            DragGesture()
                .onChanged { value in
                    offset = CGSize(
                        width: lastOffset.width + value.translation.width,
                        height: lastOffset.height + value.translation.height
                    )
                }
                .onEnded { _ in
                    withAnimation {
                        lastOffset = clampOffset(offset, in: size)
                        offset = lastOffset
                    }
                },
            
            MagnificationGesture()
                .onChanged { value in
                    if pinchStartCenter == nil {
                        pinchStartCenter = CGPoint(
                            x: size.width / 2 - offset.width,
                            y: size.height / 2 - offset.height
                        )
                    }
                    
                    let newScale = lastScale * value
                    let clampedScale = min(max(newScale, minScale), maxScale)
                    
                    if let start = pinchStartCenter {
                        let scaleChange = clampedScale / scale
                        let dx = (start.x - size.width / 2) * (scaleChange - 1)
                        let dy = (start.y - size.height / 2) * (scaleChange - 1)
                        offset.width -= dx
                        offset.height -= dy
                    }
                    
                    scale = clampedScale
                }
                .onEnded { _ in
                    pinchStartCenter = nil
                    lastScale = scale
                    withAnimation {
                        lastOffset = clampOffset(offset, in: size)
                        offset = lastOffset
                    }
                }
        )
    }
    
    private func clampOffset(_ proposed: CGSize, in size: CGSize) -> CGSize {
        let maxX = (scale - 1) * size.width / 2
        let maxY = (scale - 1) * size.height / 2
        
        var newOffset = proposed
        if newOffset.width > maxX { newOffset.width = maxX }
        if newOffset.width < -maxX { newOffset.width = -maxX }
        if newOffset.height > maxY { newOffset.height = maxY }
        if newOffset.height < -maxY { newOffset.height = -maxY }
        return newOffset
    }
}



#Preview {
    ImageTunerView(
        photo: FlickrResponse.Photo(
            id: "54718138489",
            secret: "4bd70e3925",
            server: "65535",
            farm: 66,
            title: "Walking the Dog"
        )
    )
}
