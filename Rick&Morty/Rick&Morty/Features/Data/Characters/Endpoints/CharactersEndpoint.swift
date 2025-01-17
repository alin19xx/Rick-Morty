//
//  CharactersEndpoint.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

struct CharactersEndpoint: Endpoint {
    private let params: CharactersParametersProtocol
    
    init(params: CharactersParametersProtocol) {
        self.params = params
    }
    
    var path: String {
        return "/api/character/"
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        if let name = params.name {
            items.append(URLQueryItem(name: "name", value: name))
        }
        
        if let status = params.status {
            items.append(URLQueryItem(name: "status", value: status))
        }
        
        if let species = params.species {
            items.append(URLQueryItem(name: "species", value: species))
        }
        
        if let type = params.type {
            items.append(URLQueryItem(name: "type", value: type))
        }
        
        if let gender = params.gender {
            items.append(URLQueryItem(name: "gender", value: gender))
        }
        
        if let page = params.page {
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        return items
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var bodyParameters: Data? {
        return nil
    }
}
