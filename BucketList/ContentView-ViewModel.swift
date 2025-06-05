//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Susie Kim on 5/31/25.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var mapMode = "hybrid"
        var selectedPlace: Location?
        var isUnlocked = false
        var alertShowing = false;
        var alertMessage = "";
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError? // Handle any errors that happen
            // If this succeeds, we're good to go for biometrics
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    // If we're here, that means we can successfully use biometrics. If success is true, then we have successfully unlocked
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.alertMessage = "Unlock failed. Please try again."
                        self.alertShowing = true;
                    }
                }
            } else {
                alertMessage = "Biometric authenticaion unavailable."
                alertShowing = true;
            }
        }
        
        func switchMapMode() {
            if(mapMode == "hybrid") {
                mapMode = "standard"
            } else {
                mapMode = "hybrid"
            }
        }
        
        func showAlert() {
            
        }
    }
}
