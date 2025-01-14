//
//  CharacterDecodable.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

/*
 {
     "id": 1,
     "name": "Rick Sanchez",
     "status": "Alive",
     "species": "Human",
     "type": "",
     "gender": "Male",
     "origin": {
         "name": "Earth (C-137)",
         "url": "https://rickandmortyapi.com/api/location/1"
     },
     "location": {
         "name": "Citadel of Ricks",
         "url": "https://rickandmortyapi.com/api/location/3"
     },
     "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
     "episode": [
         "https://rickandmortyapi.com/api/episode/1"
     ],
     "url": "https://rickandmortyapi.com/api/character/1",
     "created": "2017-11-04T18:48:46.250Z"
 }
 */

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
        return CharacterEntity(
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
