//
//  CharacterDetailSuccessMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import Foundation
@testable import Rick_Morty

final class CharacterDetailSuccessMock: CharacterDetailRepositoryProtocol {
    private let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func fetchCharacter(with id: Int) async throws -> CharacterDecodable {
        let decoder = JSONDecoder()
        return try decoder.decode(CharacterDecodable.self, from: data)
    }
}
