//
//  Astronaut.swift
//  Moonshot
//
//  Created by Susie Kim on 5/7/25.
//

import Foundation

// Codable allows us to make instances straight from JSON
// Identifiable allows us to make arrays of Astronauts inside ForEach
struct Astronaut: Codable, Identifiable {
    let id: String // Identifiable must have id
    let name: String
    let description: String
}

// Create a dictionary of Astronauts from our file
// Use AppBundle to get the direct path to our file, store it as an instance of Data and pass it through JSONDecoder

