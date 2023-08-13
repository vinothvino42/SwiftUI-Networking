//
//  ContentView.swift
//  SwiftUI-Closure
//
//  Created by Vinoth Vino on 12/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ZStack {
            if (vm.posts.isEmpty) {
                ProgressView()
            } else {
                List(vm.posts) { post in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(post.title)
                            .font(.title2)
                            .lineLimit(2)
                        Text(post.body)
                            .lineLimit(3)
                    }
                    .padding(.vertical)
                }
            }
        }
        .onAppear {
            vm.getPosts()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
