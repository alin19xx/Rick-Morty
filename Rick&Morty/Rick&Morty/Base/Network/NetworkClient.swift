//
//  NetworkClient.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class DefaultNetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let logger: RMLoggerProtocol
    
    init(session: URLSession = .shared,
         logger: RMLoggerProtocol = NetworkingLogger()) {
        self.session = session
        self.logger = logger
    }
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = buildURL(for: endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        let request = createURLRequest(for: endpoint, with: url)
        let requestInfo = logRequestWith(request)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            logger.log(message: "Successful response from: \(requestInfo)", level: .info)
            return decodedResponse
        } catch {
            logger.log(message: "Decoding error for: \(requestInfo) with error: \(error)", level: .error)
            throw NetworkError.decodingError(error)
        }
    }
}


// MARK: - Private Methods

extension DefaultNetworkClient {
    
    private func buildURL(for endpoint: Endpoint) -> URL? {
        var components = URLComponents(string: endpoint.basePath)
        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems
        return components?.url
    }
    
    private func createURLRequest(for endpoint: Endpoint, with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        if let bodyParameters = endpoint.bodyParameters {
            request.httpBody = bodyParameters
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    private func logRequestWith(_ request: URLRequest) -> String {
        
        let safeUrlString = request.url?.absoluteString ?? "Invalid URL"
        var logMessage = "\(request.httpMethod ?? "GET") \(safeUrlString)"
        
        if let url = request.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems, !queryItems.isEmpty {
            let queryParams = queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
            logMessage += "\nQuery Parameters: \(queryParams)"
        }
        
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            logMessage += "\nBody: \(bodyString)"
        }
        
        logger.log(message: "Starting request:\n\(logMessage)", level: .info)
        return logMessage
    }
}
