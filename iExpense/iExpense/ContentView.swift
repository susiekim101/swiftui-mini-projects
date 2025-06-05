//
//  ContentView.swift
//  iExpense
//
//  Created by Susie Kim on 5/2/25.
//
import SwiftData
import SwiftUI

// Name of item, category, cost as a double
@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}

/*@Observable
class Expenses {
    @Query var items = [ExpenseItem]
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
}*/

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
    // @State private var expenses = Expenses()
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [ExpenseItem]
    
    @State private var selectedCategory = 0
    @State private var types = ["All", "Business", "Personal"]
    @State private var showingAddExpense = false

    
    var filterItems: [ExpenseItem] {
        if(selectedCategory == 0) {
            return items
        } else if(selectedCategory == 1) {
            return items.filter { $0.type == "Business" }
        } else {
            return items.filter { $0.type == "Personal" }
        }
    }
    
    var body: some View {
        NavigationStack() {
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
                    .accessibilityElement()
                    .accessibilityLabel(item.name)
                    .accessibilityHint(item.cost)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "plus")
                    }
                    
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let item = filterItems[index]
            modelContext.delete(item)
        }
    }

}

#Preview {
    ContentView()
}
