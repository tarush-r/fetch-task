//
//  ContentView.swift
//  Fetch
//
//  Created by Tarush Tejas Rajput on 1/3/24.
//

import SwiftUI


struct RemoteImage: View {
    let url: String
    
    @State private var imageData: Data? = nil
    
    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            // Placeholder image or loading indicator
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    // Load the image asynchronously
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}



struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.desserts, id: \.self) { dessert in
                    NavigationLink(destination: DessertDetailView(dessert: dessert)) {
                        HStack {
                            RemoteImage(url: dessert.strMealThumb)
                                .frame(width: 130, height: 70)
                                .background(Color.gray)
                                .cornerRadius(8) // Optional: Add corner radius for a rounded look
                                .padding(.vertical, 8) // Add top and bottom padding

                            Text(dessert.strMeal)
                                .bold()
                                .padding(.vertical, 8) // Add top and bottom padding
                        }
                    }
                    
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    ContentView()
}
