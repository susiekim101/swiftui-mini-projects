//
//  EdutainmentAppApp.swift
//  EdutainmentApp
//
//  Created by Susie Kim on 5/1/25.
//

import SwiftUI

@main
struct EdutainmentAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(selectedNumber: .constant(2), numQuestions: .constant(5), difficulty: .constant(1))
        }
    }
}
