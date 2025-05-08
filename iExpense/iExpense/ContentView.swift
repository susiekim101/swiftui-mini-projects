//
//  ContentView.swift
//  iExpense
//
//  Created by Susie Kim on 5/2/25.
//

import SwiftUI

// Name of item, category, cost as a double
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct expenseAmount: ViewModifier {
    var amount: Double
    
    var color: Color {
        if (amount < 50) {
            return .green
        } else if (amount < 100) {
            return .yellow
        } else if (amount < 500) {
            return .orange
        } else {
            return .red
        }
    }
    
    func body(content: Content) -> some View {
        content
            .listRowBackground(color)
    }
}

extension View {
    func expenseStyle(amount: Double) -> some View {
        modifier(expenseAmount(amount: amount))
    }
}

struct ContentView: View {
    // New property to store Expenses class
    @State private var expenses = Expenses()
    @State private var selectedCategory = 0
    @State private var types = ["All", "Business", "Personal"]
    
    @State private var showingAddExpense = false
    
    var filterItems: [ExpenseItem] {
        if(selectedCategory == 0) {
            return expenses.items
        } else if(selectedCategory == 1) {
            return expenses.items.filter { $0.type == "Business" }
        } else {
            return expenses.items.filter { $0.type == "Personal" }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Filter", selection: $selectedCategory) {
                    ForEach(0..<types.count, id: \.self) { num in
                        Text("\(types[num])")
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                ForEach(filterItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    .expenseStyle(amount: item.amount)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

}

#Preview {
    ContentView()
}
