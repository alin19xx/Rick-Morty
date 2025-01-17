//
//  HomeViewModel.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol CharactersViewModelProtocol {
    var characters: [CharacterCardModel] { get }
    var currentParams: CharactersParameters { get set }
    var nextPage: Int? { get set }
    
    func fetchInitialCharacters() async
    func fetchCharacters() async
    func applyFilters(_ params: CharactersParameters) async
}

final class CharactersViewModel: BaseViewModel, CharactersViewModelProtocol {
    
    @Published var characters: [CharacterCardModel] = []
    
    private let charactersUseCase: FetchCharactersUseCaseProtocol
    var currentParams: CharactersParameters
    var nextPage: Int?
    
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
            handleError(error)
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
    
    private func handleError(_ error: NetworkError) {
        switch error {
            case .httpError(statusCode: 404):
            if let name = currentParams.name,
               !name.isEmpty {
                setError(error)
            } else if nextPage == 1, characters.isEmpty {
                setError(error)
            }
            default:
                setError(error)
        }
    }
}
