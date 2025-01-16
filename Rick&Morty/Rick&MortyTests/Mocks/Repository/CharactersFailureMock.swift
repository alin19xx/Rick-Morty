//
//  CharactersFailureMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import Foundation
@testable import Rick_Morty

final class CharactersFailureMock: CharactersRepositoryProtocol {
    private let error: NetworkError
    
    init(error: NetworkError) {
        self.error = error
    }
    
    func fetchCharacters(with params: CharactersRepositoryParameters) async throws -> CharactersResponseDecodable {
        throw error
    }
}
