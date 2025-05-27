//
//  ContentView.swift
//  FriendFace
//
//  Created by Susie Kim on 5/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        VStack {
                            Text("\(user.name)")
                            Text("\(user.isActive)")
                        }
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserView()
            }
            .task {
                if(users.isEmpty) {
                    await loadData()
                }
            }
        }
        
        /*VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Load Data") {
                print("Button tapped")
                Task {
                    await loadData()
                }
            }
            Text("\(users.count)")
        }
        .padding()*/
    }
    
    func loadData() async {
        // print("Load data called")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                // print(decodedResponse)
                users = decodedResponse
            }
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }
    
    
}

#Preview {
    ContentView()
}
