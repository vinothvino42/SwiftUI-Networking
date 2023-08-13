//
//  APIService.swift
//  SwiftUI-AsyncAwait
//
//  Created by Vinoth Vino on 13/08/23.
//

import Foundation

protocol DataFetcher {
    var session: URLSession { get }
    func request<T: Codable>(url: URL) async throws -> T
}

enum APIError: LocalizedError {
    case badRequest
    case decodingError
    case invalidData
    case invalidURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad request"
        case .decodingError:
            return "Check your response and model types"
        case .invalidData:
            return "Failed to get data"
        case .invalidURLResponse(url: let url):
            return "Invalid response from URL: \(url)"
        case .unknown:
            return "Unknown error occured"
        }
    }
}

struct APIClient: DataFetcher {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw APIError.invalidURLResponse(url: url)
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodingError
        }
    }
}



