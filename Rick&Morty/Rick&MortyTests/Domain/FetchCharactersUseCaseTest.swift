//
//  FetchCharactersUseCaseTest.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import XCTest
@testable import Rick_Morty

final class FetchCharactersUseCaseTest: XCTestCase {
    
    func testFetchCharactersUseCase_when_success() async {
        // GIVEN
        let repository = CharactersSuccessMock(data: CharactersMock.makeJsonMock())
        let useCase = DefaultFetchCharactersUseCase(repository: repository)
        
        do {
            // WHEN
            let characters = try await useCase.execute(with: CharactersUseCaseParameters())
            
            // THEN
            XCTAssertEqual(characters.count, 20, "Total characters in the mock should be 20")
            XCTAssertEqual(characters.last?.id, 20, "Character ID not match")
            XCTAssertEqual(characters.last?.name, "Ants in my Eyes Johnson", "Name not match")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testFetchCharactersUseCase_when_request_after_last_page() async {
        // GIVEN
        let repository = CharactersSuccessMock(data: CharactersLastPageMock.makeJsonMock())
        let useCase = DefaultFetchCharactersUseCase(repository: repository)
        
        var allCharacters: [CharacterEntity] = []
        
        do {
            // WHEN
            let charactersLastPage = try await useCase.execute(with: CharactersUseCaseParameters())
            allCharacters.append(contentsOf: charactersLastPage)
            
            let charactersAfterLastPage = try await useCase.execute(with: CharactersUseCaseParameters())
            allCharacters.append(contentsOf: charactersAfterLastPage)
            
            // THEN
            XCTAssertEqual(allCharacters.count, 6, "Total characters in the mock should be 6")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testFetchCharactersUseCase_when_failure() async {
        // GIVEN
        let repository = CharactersFailureMock(error: .httpError(statusCode: 404))
        let useCase = DefaultFetchCharactersUseCase(repository: repository)
        
        do {
            // WHEN
            _ = try await useCase.execute(with: CharactersUseCaseParameters())
            XCTFail("Expected failure but got success")
        } catch let error as NetworkError {
            // THEN
            switch error {
            case .httpError(let statusCode):
                XCTAssertEqual(statusCode, 404, "Expected a 404 HTTP error")
            default:
                XCTFail("Expected a 404 HTTP error but got: \(error)")
            }
        } catch {
            XCTFail("Expected a NetworkError but got: \(error)")
        }
    }
}
