//
//  User.swift
//  FriendFace
//
//  Created by Susie Kim on 5/24/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
