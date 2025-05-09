//
//  ListLayout.swift
//  Moonshot
//
//  Created by Susie Kim on 5/9/25.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.darkBackground
                    .ignoresSafeArea()
                List {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            HStack {
                                // Resizable images that scale to fit with exact frame
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                // VStack that contains dislpayName and formattedLaunchDate
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background (
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.lightBackground)
                                )
                                .overlay (
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.lightBackground)
                                    
                                )
                                
                            }
                        }
                    }
                    .listStyle(.plain)
                    .listRowBackground(Color.darkBackground)
                    
                }
                .scrollContentBackground(.hidden)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ListLayout()
}
