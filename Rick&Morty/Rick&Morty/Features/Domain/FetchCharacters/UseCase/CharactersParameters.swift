//
//  CharactersParameters.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol CharactersParametersProtocol {
    var page: Int? { get set }
    var name: String? { get set }
    var status: String? { get set }
    var species: String? { get set }
    var type: String? { get set }
    var gender: String? { get set }
}

struct CharactersParameters: CharactersParametersProtocol, Equatable {
    var page: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
}
