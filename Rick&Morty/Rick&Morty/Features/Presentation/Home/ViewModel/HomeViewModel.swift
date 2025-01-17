//
//  HomeViewModel.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

final class CharactersViewModel: BaseViewModel {
    
    @Published var characters: [CharacterCardModel] = []
    
    private let charactersUseCase: FetchCharactersUseCaseProtocol
    private var currentParams: CharactersParameters
    private var nextPage: Int?
    
    init(charactersUseCase: FetchCharactersUseCaseProtocol = DefaultFetchCharactersUseCase()) {
        self.charactersUseCase = charactersUseCase
        self.currentParams = CharactersParameters()
        self.nextPage = 1
    }
    
    func fetchInitialCharacters() async {
        nextPage = 1
        await MainActor.run { characters = [] }
        await fetchCharacters()
    }
    
    func fetchCharacters() async {
        guard !isLoading,
              let page = nextPage else { return }
        setLoading(true)
        
        do {
            currentParams.page = page
             let (newNextPage, newCharacters) = try await charactersUseCase.execute(with: currentParams)

            await MainActor.run {
                let newViewModels = newCharacters.map { $0.toHomeModel() }
                characters.append(contentsOf: newViewModels)
                nextPage = newNextPage
            }
        } catch let error as NetworkError {
            switch error {
                case .httpError(statusCode: 404):
                if let name = currentParams.name,
                    !name.isEmpty, nextPage == 1 {
                    setError(error)
                }
                default:
                    setError(error)
            }
        } catch {
            setError(.networkError(error))
        }
        
        setLoading(false)
    }
    
    func applyFilters(_ params: CharactersParameters) async {
        if params != currentParams {
            currentParams = params
            await fetchInitialCharacters()
        }
    }
}
