//
//  PaginationInfoDecodable.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

/*
 "info": {
     "count": 826,
     "pages": 42,
     "next": "https://rickandmortyapi.com/api/character?page=2",
     "prev": null
 }
 */

struct PaginationInfoDecodable: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
