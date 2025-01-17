//
//  FetchDetailUseCaseMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 17/1/25.
//

import Foundation
@testable import Rick_Morty

final class FetchCharacterDetailUseCaseMock: FetchCharacterDetailUseCaseProtocol {
    var character: CharacterEntity?
    var error: NetworkError?
    
    func execute(with id: Int) async throws -> CharacterEntity {
        if let character = character {
            return character
        } else if let error = error {
            throw error
        } else {
            throw NetworkError.unknown
        }
    }
}
