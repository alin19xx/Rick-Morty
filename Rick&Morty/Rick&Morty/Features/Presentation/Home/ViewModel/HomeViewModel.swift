//
//  HomeViewModel.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

@MainActor
final class CharactersViewModel: ObservableObject {
    
    @Published var characters: [CharacterCardModel] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let charactersUseCase: FetchCharactersUseCaseProtocol
    private var currentParams: CharactersUseCaseParameters
    private var hasMorePages: Bool = true
    
    init(charactersUseCase: FetchCharactersUseCaseProtocol = DefaultFetchCharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
        self.currentParams = CharactersUseCaseParameters()
        
        fetchInitialCharacters()
    }
    
    func fetchInitialCharacters() {
        charactersUseCase.resetPagination()
        characters = []
        Task { await fetchCharacters() }
    }
    
    func fetchCharacters() async {
        guard !isLoading && hasMorePages else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let newCharacters = try await charactersUseCase.execute(with: currentParams)
            let newViewModels = newCharacters.map { $0.toHomeModel() }
            
            characters.append(contentsOf: newViewModels)
            hasMorePages = !newViewModels.isEmpty
        } catch {
            errorMessage = "Failed to load characters: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func applyFilters(_ params: CharactersUseCaseParameters) {
        if params != currentParams {
            currentParams = params
            fetchInitialCharacters()
        }
    }
}
