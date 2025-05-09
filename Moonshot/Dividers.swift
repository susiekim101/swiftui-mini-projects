//
//  Dividers.swift
//  Moonshot
//
//  Created by Susie Kim on 5/9/25.
//

import SwiftUI

struct Dividers: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    Dividers()
}
