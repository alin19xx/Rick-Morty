//
//  CharactersRepository.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol CharactersRepositoryProtocol {
    func fetchCharacters(with params: CharactersRepositoryParameters) async throws -> CharactersResponseDecodable
}

final class DefaultCharacterListRepository: CharactersRepositoryProtocol {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchCharacters(with params: CharactersRepositoryParameters) async throws -> CharactersResponseDecodable {
        let endpoint = CharactersEndpoint(params: params)
        let response: CharactersResponseDecodable = try await networkClient.request(endpoint: endpoint)
        return response
    }
}
