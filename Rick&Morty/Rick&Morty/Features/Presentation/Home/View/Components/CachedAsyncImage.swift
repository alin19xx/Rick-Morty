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
    
    private let networkClient: NetworkClientProtocol
    private let logger: RMLoggerProtocol
    
    init(
        url: String,
        networkClient: NetworkClientProtocol = DefaultNetworkClient(),
        logger: RMLoggerProtocol = UILogger(),
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder content: @escaping (Image) -> Content
    ) {
        self.url = url
        self.networkClient = networkClient
        self.logger = logger
        self.placeholder = placeholder
        self.content = content
    }
    
    var body: some View {
        Group {
            if let uiImage = loadedImage {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .task { await loadImage() }
            }
        }
        .animation(.default, value: loadedImage)
    }
    
    private func loadImage() async {
        guard let imageURL = URL(string: url) else { return }
        
        if let cachedImage = ImageCache.shared.getImage(for: imageURL) {
            loadedImage = cachedImage
            return
        }
        
        do {
            let data = try await networkClient.fetchImage(from: imageURL)
            if let uiImage = UIImage(data: data) {
                ImageCache.shared.saveImage(uiImage, for: imageURL)
                
                await MainActor.run {
                    loadedImage = uiImage
                }
            }
        } catch {
            logger.log(message: "Failed to load image: \(error)", level: .error)
        }
    }
}
