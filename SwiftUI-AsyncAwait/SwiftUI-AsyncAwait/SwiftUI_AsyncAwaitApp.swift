//
//  SwiftUI_AsyncAwaitApp.swift
//  SwiftUI-AsyncAwait
//
//  Created by Vinoth Vino on 13/08/23.
//

import SwiftUI

@main
struct SwiftUI_AsyncAwaitApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}
