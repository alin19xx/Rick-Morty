//
//  CharacterDetailViewModel.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import Foundation

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    
    @Published var character: CharacterModel?
    
    var id: Int
    private let detailUseCase: FetchCharacterDetailUseCaseProtocol
    
    @Published var isLoading: Bool = false
    @Published var error: NetworkError?
    
    init(id: Int,
         detailUseCase: FetchCharacterDetailUseCaseProtocol = DefaultFetchCharacterDetailUseCase()) {
        self.id = id
        self.detailUseCase = detailUseCase
    }
    
    func fetchCharacter() async {
        isLoading = true
        
        do {
            let characterEntity = try await detailUseCase.execute(with: id)
            character = characterEntity.toDetailViewModel()
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .networkError(error)
        }
        
        isLoading = false
    }
}
