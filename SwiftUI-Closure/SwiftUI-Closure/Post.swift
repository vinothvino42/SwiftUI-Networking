//
//  Post.swift
//  SwiftUI-Closure
//
//  Created by Vinoth Vino on 13/08/23.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}
