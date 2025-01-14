//
//  CharacterDetailEndpoint.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

struct CharacterDetailEndpoint: Endpoint {
    let id: Int
    
    var path: String {
        return "/api/character/\(id)"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var bodyParameters: Data? {
        return nil
    }
}
