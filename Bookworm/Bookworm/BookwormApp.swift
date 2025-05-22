//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Susie Kim on 5/20/25.
//
import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Made a Container and put it in SwiftUI's environment so it's good to use
        .modelContainer(for: Book.self)
    }
}
