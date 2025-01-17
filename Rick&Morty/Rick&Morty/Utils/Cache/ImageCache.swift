//
//  ImageCache.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import UIKit

final class ImageCache {
    /// We use a singleton because, in this case, like in the detail view,
    /// the image URLs are the same
    static let shared = ImageCache()
    
    private init() {}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
