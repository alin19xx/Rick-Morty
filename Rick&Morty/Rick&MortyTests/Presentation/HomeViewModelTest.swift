//
//  HomeViewModelTest.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 17/1/25.
//

import XCTest
@testable import Rick_Morty

final class HomeViewModelTest: XCTestCase {
    
    func testFetchInitialCharacters_whenSuccess() async {
        // Expectation
        let expectation = XCTestExpectation(description: "Characters should be updated")
        
        // GIVEN
        let mockUseCase = FetchCharactersUseCaseMock()
        mockUseCase.result = (nextPage: 2,
                              characters: [CharacterEntity(
                                id: 1,
                                name: "Rick",
                                status: "Alive",
                                species: "Human",
                                type: "",
                                gender: "Male",
                                originName: "Earth",
                                locationName: "Earth",
                                imageUrl: "url"
                              )])
        let viewModel = CharactersViewModel(charactersUseCase: mockUseCase)
        
        let cancellable = viewModel.$characters
            .dropFirst()
            .sink { characters in
                if !characters.isEmpty {
                    expectation.fulfill()
                }
            }

        // WHEN
        await viewModel.fetchInitialCharacters()

        // THEN
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.characters.first?.id, 1, "The first character's ID should be 1")
        XCTAssertEqual(viewModel.nextPage, 2, "Next page should be 2")
        XCTAssertFalse(viewModel.isLoading, "Loading state should be false after fetch")
        cancellable.cancel()
    }
    
    func testFetchInitialCharacters_whenError_onFirstLoad() async {
        // Expectation
        let expectation = XCTestExpectation(description: "Error should be 404")
        
        // GIVEN
        let mockUseCase = FetchCharactersUseCaseMock()
        mockUseCase.error = .httpError(statusCode: 404)
        let viewModel = CharactersViewModel(charactersUseCase: mockUseCase)
        
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
        await viewModel.fetchInitialCharacters()
        
        // THEN
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertTrue(viewModel.characters.isEmpty, "Characters should be empty on error")
        cancellable.cancel()
    }
    
    func testApplyFilters_whenParamsChange() async {
        // GIVEN
        let mockUseCase = FetchCharactersUseCaseMock()
        mockUseCase.result = (
            nextPage: 2,
            characters: [CharacterEntity(
                id: 1,
                name: "Rick",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                originName: "Earth",
                locationName: "Earth",
                imageUrl: "url"
            )]
        )
        let viewModel = CharactersViewModel(charactersUseCase: mockUseCase)
        
        // WHEN
        let newParams = CharactersParameters(status: "Alive")
        await viewModel.applyFilters(newParams)
        
        // THEN
        XCTAssertFalse(viewModel.characters.isEmpty, "Characters should not be empty after applying filters")
        XCTAssertEqual(viewModel.currentParams.status, "Alive", "The status parameter should be updated")
    }
    
    func testPaginationStops_afterLastPage() async {
        // GIVEN
        let mockUseCase = FetchCharactersUseCaseMock()
        mockUseCase.result = (nextPage: nil, characters: [])
        let viewModel = CharactersViewModel(charactersUseCase: mockUseCase)
        
        // WHEN
        await viewModel.fetchCharacters()
        
        // THEN
        XCTAssertNil(viewModel.nextPage, "Next page should be nil after the last page")
    }
}
