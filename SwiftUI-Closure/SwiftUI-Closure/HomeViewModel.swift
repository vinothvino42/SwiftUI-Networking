//
//  HomeViewModel.swift
//  SwiftUI-Closure
//
//  Created by Vinoth Vino on 13/08/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private let client = APIClient()
    
    func getPosts() {
        client.request(url: URL(string: "https://jsonplaceholder.typicode.com/posts/")!) { (result: Result<[Post], APIError>) in
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                print("Failed to get datas: \(error)")
            }
        }
    }
}
