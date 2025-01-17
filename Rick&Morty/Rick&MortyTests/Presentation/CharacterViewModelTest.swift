//
//  CharacterViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 17/1/25.
//

import XCTest
@testable import Rick_Morty

final class CharacterDetailViewModelTests: XCTestCase {
    
    func testFetchCharacter_whenSuccess() async {
        // Expectation
        let expectation = XCTestExpectation(description: "Character should be updated")
        
        // GIVEN
        let mockUseCase = FetchCharacterDetailUseCaseMock()
        let characterEntity = CharacterEntity(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            originName: "Earth",
            locationName: "Earth",
            imageUrl: "url"
        )
        mockUseCase.character = characterEntity
        let viewModel = CharacterDetailViewModel(id: 1, detailUseCase: mockUseCase)
        
        let cancellable = viewModel.$character
            .dropFirst()
            .sink { character in
                if character?.id == 1 {
                    expectation.fulfill()
                }
            }
        
        // WHEN
        await viewModel.fetchCharacter()
        
        // THEN
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.character?.id, 1, "Character ID should match")
        XCTAssertEqual(viewModel.character?.name, "Rick Sanchez", "Character name should match")
        XCTAssertFalse(viewModel.isLoading, "Loading state should be false after fetch")
        cancellable.cancel()
    }
    
    func testFetchCharacter_whenError() async {
        // Expectation
        let expectation = XCTestExpectation(description: "Error should be 404")
        
        // GIVEN
        let mockUseCase = FetchCharacterDetailUseCaseMock()
        mockUseCase.error = .httpError(statusCode: 404)
        let viewModel = CharacterDetailViewModel(id: 1, detailUseCase: mockUseCase)
        
        let cancellable = viewModel.$error
            .dropFirst()
            .sink { error in
                switch error {
                case .httpError(statusCode: 404):
                    expectation.fulfill()
                default:
                    XCTFail("Unexpected error")
                }
            }
        
        // WHEN
        await viewModel.fetchCharacter()
        
        // THEN
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertTrue(viewModel.character == nil, "Character should be nil")
        cancellable.cancel()
    }
}
