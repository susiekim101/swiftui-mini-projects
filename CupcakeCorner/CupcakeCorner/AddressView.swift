//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Susie Kim on 5/16/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
      
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                    .onChange(of: order.name, order.saveAddress)
                TextField("StreetAddress", text: $order.streetAddress)
                    .onChange(of: order.streetAddress, order.saveAddress)
                TextField("City", text: $order.city)
                    .onChange(of: order.city, order.saveAddress)
                TextField("Zip", text: $order.zip)
                    .onChange(of: order.zip, order.saveAddress)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            order.loadAddress()
        }
    }
}

#Preview {
    AddressView(order: Order())
}
