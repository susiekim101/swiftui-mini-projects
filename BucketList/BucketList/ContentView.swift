//
//  ContentView.swift
//  BucketList
//
//  Created by Susie Kim on 5/27/25.
//
import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    // Add our ViewModel in our ContentView and change variable names to reflect viewModel.NAME
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            VStack {
                Button("Switch Map Mode") {
                    viewModel.switchMapMode()
                }
                
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(viewModel.mapMode == "hybrid" ? .hybrid : .standard)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
                .alert("Error", isPresented: $viewModel.alertShowing) {
                    Button("Try Again") { }
                } message: {
                    Text(viewModel.alertMessage)
                }
            }
        } else {
            // A button that triggers the authenticate method since device is unlocked
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
