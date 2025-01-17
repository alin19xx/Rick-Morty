//
//  CharactersResponseDecodable.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

struct CharactersResponseDecodable: Codable {
    let info: PaginationInfoDecodable
    let results: [CharacterDecodable]
}
