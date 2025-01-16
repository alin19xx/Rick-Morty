//
//  CharactersSuccessMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import Foundation
@testable import Rick_Morty

final class CharactersSuccessMock: CharactersRepositoryProtocol {

    private let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func fetchCharacters(with params: CharactersRepositoryParameters) async throws -> CharactersResponseDecodable {
        let decoder = JSONDecoder()
        return try decoder.decode(CharactersResponseDecodable.self, from: data)
    }
}
