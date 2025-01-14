//
//  LocationDecodable.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

/*
 "origin": {
     "name": "Earth (C-137)",
     "url": "https://rickandmortyapi.com/api/location/1"
 },
 "location": {
     "name": "Citadel of Ricks",
     "url": "https://rickandmortyapi.com/api/location/3"
 }
 */

struct LocationDecodable: Codable {
    let name: String
    let url: String
}
