//
//  CharacterDecodable.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

struct CharacterDecodable: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationDecodable
    let location: LocationDecodable
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

extension CharacterDecodable {
    func toDomain() -> CharacterEntity {
        CharacterEntity(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            originName: origin.name,
            locationName: location.name,
            imageUrl: image
        )
    }
}
