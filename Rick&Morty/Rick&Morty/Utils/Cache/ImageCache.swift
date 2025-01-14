//
//  ImageCache.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import UIKit

final class ImageCache {
    /// Creamos un singleton porque en este caso, como en la vista de detalle
    /// las urls de las imagenes son las mismas, al tener una sola instancia,
    /// la carga sera instantanea
    static let shared = ImageCache()
    
    /// Evitamos que se puedan crear instancias nuevas
    private init() {}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func saveImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
