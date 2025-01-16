//
//  CharacterDetailFailureMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import Foundation
@testable import Rick_Morty

final class CharacterDetailFailureMock: CharacterDetailRepositoryProtocol {
    private let error: NetworkError
    
    init(error: NetworkError) {
        self.error = error
    }
    
    func fetchCharacter(with id: Int) async throws -> Rick_Morty.CharacterDecodable {
        throw error
    }
}
