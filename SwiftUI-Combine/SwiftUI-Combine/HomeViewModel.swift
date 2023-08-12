//
//  HomeViewModel.swift
//  SwiftUI-Combine
//
//  Created by Vinoth Vino on 12/08/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private let client = APIClient()
    private var cancellable: AnyCancellable?
    
    func getPosts() {
        cancellable = client.request(url: URL(string: "https://jsonplaceholder.typicode.com/posts/")!)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { posts in
                self.posts = posts
            })
    }
}
