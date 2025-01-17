//
//  CharacterDetailViewModel.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import Foundation

@MainActor
final class CharacterDetailViewModel: BaseViewModel {
    
    @Published var character: CharacterModel?
    
    var id: Int
    private let detailUseCase: FetchCharacterDetailUseCaseProtocol
    
    init(id: Int,
         detailUseCase: FetchCharacterDetailUseCaseProtocol = DefaultFetchCharacterDetailUseCase()) {
        self.id = id
        self.detailUseCase = detailUseCase
    }
    
    func fetchCharacter() async {
        setLoading(true)
        
        do {
            let characterEntity = try await detailUseCase.execute(with: id)
            character = characterEntity.toDetailViewModel()
        } catch let error as NetworkError {
            setError(error)
            self.error = error
        } catch {
            setError(.networkError(error))
        }
        
        setLoading(false)
    }
}
