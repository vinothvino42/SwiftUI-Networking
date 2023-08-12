//
//  Post.swift
//  SwiftUI-Combine
//
//  Created by Vinoth Vino on 12/08/23.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}
