//
//  ContentView.swift
//  Instafilter
//
//  Created by Susie Kim on 5/24/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    var filterText: String {
        if(currentFilter.inputKeys.contains(kCIInputIntensityKey)) {
            return "Intensity"
        } else if(currentFilter.inputKeys.contains(kCIInputRadiusKey)) {
            return "Radius"
        } else if(currentFilter.inputKeys.contains(kCIInputScaleKey)) {
            return "Scale"
        }
        return "Intensity"
    }
    
    // Optional because there isn't one by default
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    // Context (Renders CIImage -> CGImage) Converts a recipe to a series of pixels
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext() // The Context won't change
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                // PhotosPicker is like a button that lets you select images. Can change what's being displayed as the button
                PhotosPicker(selection: $selectedItem) {
                    // Unwrap optional using if let when you need it
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                HStack {
                    Text("\(filterText)")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                        .disabled(processedImage == nil)
                }
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                        .disabled(processedImage == nil)
                    
                    Spacer()
                    
                    // If there is an image to share, then share it
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Selet a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize())}
                Button("Edges") { setFilter(CIFilter.edges())}
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur())}
                Button("Pixellate") { setFilter(CIFilter.pixellate())}
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask())}
                Button("Vignette") { setFilter(CIFilter.vignette())}
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return } // Asking to give the pure binary data of selectedItem
            // We can't use image here because we can't feed it into CoreImage (only UIImage)
            guard let inputImage = UIImage(data: imageData) else { return } // Give me an image from the item by first converting into raw data and into UIImage
            let beginImage = CIImage(image: inputImage) // convert inputImage to a CIImage
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        else if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        else if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return } // We actually have pixels in our CGImage, so we can create our UIImage
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage() // Triggered each time image changes
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
