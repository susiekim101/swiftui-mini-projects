//
//  Order.swift
//  CupcakeCorner
//
//  Created by Susie Kim on 5/16/25.
//

import Foundation

@Observable
class Order: Codable {
    /*enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkls = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }*/
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if (name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cakse
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    private var saveKey = "SavedOrder"
    
    func saveAddress() {
        do {
            let data = try JSONEncoder().encode(self)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Failed to save order: \(error.localizedDescription)")
        }
    }
    
    func loadAddress() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            print("No saved order found")
            return
        }
        do {
            let saved = try JSONDecoder().decode(Order.self, from: data)
            self.name = saved.name
            self.streetAddress = saved.streetAddress
            self.city = saved.city
            self.zip = saved.zip
        } catch {
            print("Failed to load order: \(error.localizedDescription)")
        }
    }
}
