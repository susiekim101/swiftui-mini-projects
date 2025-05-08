//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Susie Kim on 5/7/25.
//

import SwiftUI

// Extend ShapeStyle only when it's being used by Color
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
