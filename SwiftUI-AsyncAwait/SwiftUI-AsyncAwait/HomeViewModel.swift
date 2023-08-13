//
//  HomeViewModel.swift
//  SwiftUI-AsyncAwait
//
//  Created by Vinoth Vino on 13/08/23.
//


import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private let client = APIClient()
    
    func getPosts() async {
        do {
            let response: [Post] = try await client.request(url: URL(string: "https://jsonplaceholder.typicode.com/posts/")!)
            posts = response
        } catch {
            print("Failed to get data")
        }
    }
}
