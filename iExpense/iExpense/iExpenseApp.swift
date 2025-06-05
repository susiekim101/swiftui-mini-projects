//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Susie Kim on 5/2/25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
