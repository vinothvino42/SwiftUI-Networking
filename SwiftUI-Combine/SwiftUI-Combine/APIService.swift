//
//  APIService.swift
//  SwiftUI-Combine
//
//  Created by Vinoth Vino on 12/08/23.
//

import Foundation
import Combine

protocol DataFetcher {
    var session: URLSession { get }
    func request(url: URL) -> AnyPublisher<Data, Error>
}

enum APIError: LocalizedError {
    case badRequest
    case decodingError
    case invalidURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad request"
        case .decodingError:
            return "Check your response and model types"
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
    
    func request(url: URL) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw APIError.invalidURLResponse(url: url)
                }
                return data
            }
            .retry(3)
            .eraseToAnyPublisher()
    }
}

