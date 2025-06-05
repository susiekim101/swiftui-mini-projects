//
//  Result.swift
//  BucketList
//
//  Created by Susie Kim on 5/30/25.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        // In our optional terms, find the "description" key which may or may not exist
        // If it exists, then the first one there is the one that we care about
        // If none of those exist, then print another string
        terms?["description"]?.first ?? "No further information"
    }
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
