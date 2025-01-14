//
//  CachedAsyncImage.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import SwiftUI

struct CachedAsyncImage<Placeholder: View, Content: View>: View {
    let url: String
    let placeholder: () -> Placeholder
    let content: (Image) -> Content
    
    @State private var loadedImage: UIImage?
    
    var body: some View {
        Group {
            if let uiImage = loadedImage {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .animation(.default, value: loadedImage)
    }
    
    private func loadImage() {
        guard let imageURL = URL(string: url) else { return }
        
        if let cachedImage = ImageCache.shared.getImage(for: imageURL) {
            loadedImage = cachedImage
        } else {
            Task {
                let (data, _) = try await URLSession.shared.data(from: imageURL)
                if let uiImage = UIImage(data: data) {
                    ImageCache.shared.saveImage(uiImage, for: imageURL)
                    loadedImage = uiImage
                }
            }
        }
    }
}
