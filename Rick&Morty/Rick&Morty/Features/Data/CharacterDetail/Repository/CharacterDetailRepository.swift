//
//  CharacterDetailRepository.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol CharacterDetailRepositoryProtocol {
    func fetchCharacter(with id: Int) async throws -> CharacterDecodable
}

final class DefaultCharacterDetailRepository: CharacterDetailRepositoryProtocol {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchCharacter(with id: Int) async throws -> CharacterDecodable {
        do {
            let endpoint = CharacterDetailEndpoint(id: id)
            let response: CharacterDecodable = try await networkClient.request(endpoint: endpoint)
            return response
        } catch let error as NetworkError {
            throw error
        }
    }
}
