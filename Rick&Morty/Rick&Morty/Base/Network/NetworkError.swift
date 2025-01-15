//
//  NetworkError.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case networkError(Error)
    case httpError(statusCode: Int)
    case noData
    case decodingError(Error)
}
