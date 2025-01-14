//
//  CharacterEntity.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

struct CharacterEntity {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let originName: String
    let locationName: String
    let imageUrl: String
}

extension CharacterEntity {
    func toHomeModel() -> CharacterCardModel {
        return CharacterCardModel(
            id: id,
            name: name,
            imageUrl: imageUrl
        )
    }
    
    func toDetailViewModel() -> CharacterModel {
        return CharacterModel(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            originName: originName,
            locationName: locationName,
            imageUrl: imageUrl)
    }
}
