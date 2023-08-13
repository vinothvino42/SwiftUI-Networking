//
//  APIService.swift
//  SwiftUI-Closure
//
//  Created by Vinoth Vino on 12/08/23.
//

import Foundation

protocol DataFetcher {
    var session: URLSession { get }
    func request<T: Codable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void)
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
    
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.badRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(APIError.invalidURLResponse(url: url)))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }
}


