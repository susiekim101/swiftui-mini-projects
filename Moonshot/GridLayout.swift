//
//  GridLayout.swift
//  Moonshot
//
//  Created by Susie Kim on 5/9/25.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // Adaptive column layout
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            // Scrolling vertical grid
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink(value: mission) {
                            VStack {
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
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                            // MissionView(mission: mission, astronauts: astronauts)
                        } /*label: {
                            
                        }*/
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .background(.darkBackground)
            // Prefer default darkmode
            .preferredColorScheme(.dark)
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
    }
}

#Preview {
    GridLayout()
}
