//
//  NetworkClient.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import Foundation

protocol NetworkClientProtocol {
    /// Sends an asynchronous HTTP request and decodes the response into a specific type.
    /// - Parameter endpoint: The endpoint containing the request configuration (URL, method, headers, etc.).
    /// - Returns: A decoded object of the specified type.
    /// - Throws: A `NetworkError` if the request fails, the response status is invalid, or decoding fails.
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T

    /// Fetches image data from a given URL.
    /// - Parameter url: The URL to fetch the image from.
    /// - Returns: The raw image data.
    /// - Throws: A `NetworkError` if the request fails or the response status is invalid.
    func fetchImage(from url: URL) async throws -> Data
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
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse,
                !(200...299).contains(httpResponse.statusCode) {
                logger.log(message: "HTTP error for: \(requestInfo) with status code: \(httpResponse.statusCode)", level: .error)
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                logger.log(message: "No data received from: \(requestInfo)", level: .error)
                throw NetworkError.noData
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            logger.log(message: "Successful response from: \(requestInfo)", level: .info)
            return decodedResponse
        } catch let error as NetworkError {
            throw error
        } catch {
            logger.log(message: "Decoding error for: \(requestInfo) with error: \(error)", level: .error)
            throw NetworkError.decodingError(error)
        }
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        logger.log(message: "Fetching image from: \(url)", level: .info)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                logger.log(message: "HTTP error for image URL: \(url), status code: \(httpResponse.statusCode)", level: .error)
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            
            return data
        } catch {
            logger.log(message: "Failed to fetch image from URL: \(url) with error: \(error)", level: .error)
            throw NetworkError.networkError(error)
        }
    }
}


// MARK: - Private Methods

extension DefaultNetworkClient {
    
    /// Builds a URL from the given `Endpoint`.
    /// - Parameter endpoint: The endpoint containing the base path, path, and query items for the request.
    /// - Returns: A fully constructed `URL` or `nil` if the URL is invalid.
    private func buildURL(for endpoint: Endpoint) -> URL? {
        var components = URLComponents(string: endpoint.basePath)
        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems
        return components?.url
    }
    
    /// Creates a `URLRequest` using the provided `Endpoint` and `URL`.
    /// - Parameters:
    ///   - endpoint: The endpoint containing HTTP method, headers, and body parameters.
    ///   - url: The constructed `URL` for the request.
    /// - Returns: A configured `URLRequest` object.
    private func createURLRequest(for endpoint: Endpoint, with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        if let bodyParameters = endpoint.bodyParameters {
            request.httpBody = bodyParameters
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    /// Logs details about the given `URLRequest` for debugging purposes.
    /// - Parameter request: The `URLRequest` to log.
    /// - Returns: A string containing the formatted log message.
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
