//
//  NetworkService.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

// MARK: -BACK-END CODE FOR DATA

//
//import Foundation
//import Combine
//
//class NetworkService {
//    private let baseURL: URL
//    private let session: URLSession
//
//    init(baseURL: URL, session: URLSession = .shared) {
//        self.baseURL = baseURL
//        self.session = session
//    }
//
//    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
//        let url = baseURL.appendingPathComponent(endpoint.path)
//        var request = URLRequest(url: url)
//        request.httpMethod = endpoint.method.rawValue
//
//        // Add headers
//        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
//
//        // Add parameters to URL for GET requests
//        if let parameters = endpoint.parameters, endpoint.method == .get {
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
//            request.url = components.url
//        }
//
//        // Add body for non-GET requests
//        if endpoint.method != .get, let parameters = endpoint.parameters {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        }
//
//        // Perform request
//        let (data, response) = try await session.data(for: request)
//
//        // Check for HTTP errors
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw NetworkError.invalidResponse
//        }
//
//        guard (200...299).contains(httpResponse.statusCode) else {
//            throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
//        }
//
//        // Decode response
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            decoder.dateDecodingStrategy = .iso8601
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            throw NetworkError.decodingError(error)
//        }
//    }
//}
//
//struct Endpoint {
//    let path: String
//    let method: HTTPMethod
//    let parameters: [String: Any]?
//    let headers: [String: String]?
//
//    init(path: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, headers: [String: String]? = nil) {
//        self.path = path
//        self.method = method
//        self.parameters = parameters
//        self.headers = headers
//    }
//}
//
//enum HTTPMethod: String {
//    case get = "GET"
//    case post = "POST"
//    case put = "PUT"
//    case delete = "DELETE"
//    case patch = "PATCH"
//}
//
//enum NetworkError: Error {
//    case invalidURL
//    case invalidResponse
//    case httpError(statusCode: Int, data: Data)
//    case decodingError(Error)
//    case unknownError(Error)
//}
