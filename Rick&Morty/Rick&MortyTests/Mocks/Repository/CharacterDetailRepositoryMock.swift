//
//  CharacterDetailRepositoryMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import Foundation
@testable import Rick_Morty

final class CharacterDetailRepositoryMock: CharacterDetailRepositoryProtocol {
    
    private let data: Data?
    private let error: NetworkError?
    
    init(data: Data? = nil, error: NetworkError? = nil) {
        self.data = data
        self.error = error
    }
    
    func fetchCharacter(with id: Int) async throws -> CharacterDecodable {
        if let data = data {
            let decoder = JSONDecoder()
            return try decoder.decode(CharacterDecodable.self, from: data)
        } else if let error = error {
            throw error
        } else {
            throw NetworkError.unknown
        }
    }
}
