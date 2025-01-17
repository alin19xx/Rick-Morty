//
//  FetchCharactersUseCaseMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 17/1/25.
//

import Foundation
@testable import Rick_Morty

final class FetchCharactersUseCaseMock: FetchCharactersUseCaseProtocol {
    var result: (nextPage: Int?, characters: [CharacterEntity])?
    var error: NetworkError?
    
    init(result: (nextPage: Int?, characters: [CharacterEntity])? = nil,
         error: NetworkError? = nil) {
        self.result = result
        self.error = error
    }
    
    func execute(with params: CharactersParametersProtocol) async throws -> (nextPage: Int?, characters: [CharacterEntity]) {
        if let result = result {
            return result
        } else if let error = error {
            throw error
        } else {
            throw NetworkError.unknown
        }
    }
}
