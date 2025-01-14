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
    @Published var errorMessage: String?
    
    init(id: Int,
         detailUseCase: FetchCharacterDetailUseCaseProtocol = DefaultFetchCharacterDetailUseCase()) {
        self.id = id
        self.detailUseCase = detailUseCase
    }
    
    func fetchCharacter() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let characterEntity = try await detailUseCase.execute(with: id)
            character = characterEntity.toDetailViewModel()
        } catch {
            errorMessage = "Failed to load character: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
