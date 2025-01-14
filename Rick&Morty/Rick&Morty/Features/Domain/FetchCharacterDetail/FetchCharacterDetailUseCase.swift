//
//  FetchCharacterDetailUseCase.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import Foundation

protocol FetchCharacterDetailUseCaseProtocol {
    func execute(with id: Int) async throws -> CharacterEntity
}

final class DefaultFetchCharacterDetailUseCase: FetchCharacterDetailUseCaseProtocol {
    private let repository: CharacterDetailRepositoryProtocol
    
    init(repository: CharacterDetailRepositoryProtocol = DefaultCharacterDetailRepository()) {
        self.repository = repository
    }
    
    func execute(with id: Int) async throws -> CharacterEntity {
        let response = try await repository.fetchCharacter(with: id)
        return response.toDomain()
    }
}
