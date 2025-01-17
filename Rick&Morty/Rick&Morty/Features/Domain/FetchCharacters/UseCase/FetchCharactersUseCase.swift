//
//  FetchCharactersUseCase.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol FetchCharactersUseCaseProtocol {
    func execute(with params: CharactersParametersProtocol) async throws -> (nextPage: Int?, characters: [CharacterEntity])
}

final class DefaultFetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let repository: CharactersRepositoryProtocol
    
    init(repository: CharactersRepositoryProtocol = DefaultCharacterListRepository()) {
        self.repository = repository
    }
    
    func execute(with params: CharactersParametersProtocol) async throws -> (nextPage: Int?, characters: [CharacterEntity]) {
        let response = try await repository.fetchCharacters(with: params)
        
        let nextPage = extractPageNumber(from: response.info.next)
        let characters = response.results.map { $0.toDomain() }
        
        return (nextPage, characters)
    }
}

extension DefaultFetchCharactersUseCase {
    private func extractPageNumber(from url: String?) -> Int? {
        guard let url = url,
              let components = URLComponents(string: url),
              let pageItem = components.queryItems?.first(where: { $0.name == "page" }),
              let pageValue = pageItem.value,
              let pageNumber = Int(pageValue) else {
            return nil
        }
        return pageNumber
    }
}
