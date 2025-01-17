//
//  PaginationInfoDecodable.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

struct PaginationInfoDecodable: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
