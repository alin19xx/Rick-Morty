//
//  FetchCharactersUseCase.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol FetchCharactersUseCaseProtocol {
    func execute(with params: CharactersUseCaseParameters) async throws -> [CharacterEntity]
    func resetPagination()
}

final class DefaultFetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let repository: CharactersRepositoryProtocol
    
    private var currentParams: CharactersUseCaseParameters
    private var nextPage: Int?
    
    init(repository: CharactersRepositoryProtocol = DefaultCharacterListRepository()) {
        self.repository = repository
        self.currentParams = CharactersUseCaseParameters()
        self.nextPage = 1
    }
    
    func execute(with params: CharactersUseCaseParameters) async throws -> [CharacterEntity] {
        /// Comprobamos si los parametros son diferentes, si lo son,
        /// reseteamos la paginacion y seteamos los nuevos parametros
        if params != currentParams {
            resetPagination()
            currentParams = params
        }
        
        /// Esta comprobacion solo va a ejecutar el else en el momento que el parametro
        /// next de la paginacion sea nil, lo que significara que hemos llegado a la ultima pagina
        guard let page = nextPage else { return [] }
        
        /// La primera vez siempre vamos a tener page = 1, para las siguientes ejecuciones
        let repoParams = CharactersRepositoryParameters(
                    page: page,
                    name: params.name,
                    status: params.status,
                    species: params.species,
                    type: params.type,
                    gender: params.gender
                )
        
        do {
            let response = try await repository.fetchCharacters(with: repoParams)
            
            /// Extraemos de la URL del campo "next" la proxima pagina.
            /// Otra opcion que seria igual de valida podria ser guardarse la url, pero como ya tenemos el endpoint montado, tiene mas sentido trabajar con el numero de pagina
            nextPage = extractPageNumber(from: response.info.next)
            return response.results.map { $0.toDomain() }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
    func resetPagination() {
        nextPage = 1
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
