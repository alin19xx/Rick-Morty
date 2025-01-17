//
//  CharactersRepositoryMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import Foundation
@testable import Rick_Morty

final class CharactersRepositoryMock: CharactersRepositoryProtocol {

    private let data: Data?
    private let error: NetworkError?
    
    init(data: Data? = nil, error: NetworkError? = nil) {
        self.data = data
        self.error = error
    }
    
    func fetchCharacters(with params: CharactersRepositoryParameters) async throws -> CharactersResponseDecodable {
        if let data = data {
            let decoder = JSONDecoder()
            return try decoder.decode(CharactersResponseDecodable.self, from: data)
        } else if let error = error {
            throw error
        } else {
            throw NetworkError.unknown
        }
    }
}
