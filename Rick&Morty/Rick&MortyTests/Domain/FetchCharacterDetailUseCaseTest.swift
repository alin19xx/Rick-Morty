//
//  FetchCharacterDetailUseCaseTest.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import XCTest
@testable import Rick_Morty

final class FetchCharacterDetailUseCaseTest: XCTestCase {
    
    func testFetchCharactrerDetail_when_success() async {
        // GIVEN
        let repository = CharacterDetailSuccessMock(data: CharacterDetailMock.makeJsonMock())
        let useCase = DefaultFetchCharacterDetailUseCase(repository: repository)
        
        do {
            // WHEN
            let character = try await useCase.execute(with: 1)
            
            // THEN
            XCTAssertEqual(character.name, "Rick Sanchez", "Name not match")
            XCTAssertEqual(character.imageUrl, "https://rickandmortyapi.com/api/character/avatar/1.jpeg", "ImageURL not match")
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testCharacterDetail_when_Failure() async {
        // GIVEN
        let repository = CharacterDetailFailureMock(error: .httpError(statusCode: 404))
        let useCase = DefaultFetchCharacterDetailUseCase(repository: repository)
        
        do {
            // WHEN
            _ = try await useCase.execute(with: 0)
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
