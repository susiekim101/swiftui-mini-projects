//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Susie Kim on 5/19/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://media.istockphoto.com/id/177047298/photo/vanilla-cupcakes-with-pink-yellow-and-blue-icing-isolated.jpg?s=612x612&w=0&k=20&c=JfKDY3kL7prAt0NJ0efXIV8xn51_lJuIEctxDfdYXqU="), scale: 3) { image in
                    image
                        .resizable()
                         .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    // this function CAN go to sleep (uploading data is also async, not just retrieving data)
    func placeOrder() async {
        // Convert our current order object to a JSON data to be sent over the internet
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        /* Tell Swift how to send that over the network
         URL Request, but there are additional options to add information
         Need to attach data in a very specific way so the server knows how to handle it
         Specify GET or POST
         Provide a content type to determie what kind of data we're sending which affects the way the serve handdles it
         Specified with MIME type which has thousands of very specific options
         Create a new URL request object, configure it to send JSON data using a POST request and send it with a URL request ot handle data
        */
        /* Force unwrap for url String. Make it nonoptional. Creating URL from strings might fail, but in this case it's handtyped and we know it's safe.*/
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        // Some JSON data inside our information/request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        /*
         All set to make our nextwork call ,which we'll call with a new method call
         */
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // Read the result back. If something has gone wrong, then our catch block will run
            // We can use JSON decoder to convert it back to an object.
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            // Networking has a small problem.
        } catch {
            confirmationMessage = "Your request failed. Please try again";
            showingConfirmation = true
            print("Check out failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
