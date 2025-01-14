//
//  CharactersRepositoryParameters.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

struct CharactersRepositoryParameters {
    /// Paginacion
    var page: Int? = nil
    
    /// Filtros
    var name: String? = nil
    var status: String? = nil
    var species: String? = nil
    var type: String? = nil
    var gender: String? = nil
}
