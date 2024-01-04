//
//  DessertDetails.swift
//  Fetch
//
//  Created by Tarush Tejas Rajput on 1/4/24.
//

import Foundation
import SwiftUI

// Dessert Detail View
struct DessertDetailView: View {
    let dessert: Dessert
    
    @State private var dessertDetails: DessertDetails?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                RemoteImage(url: dessert.strMealThumb)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height * 0.4) // Adjust the multiplier as needed
                    .clipped().cornerRadius(15).shadow(color: Color.black.opacity(0.3), radius: 15)
                
                Spacer()
                Divider()
                if let dessertDetails = dessertDetails {
                    Section(header: Text("Ingredients").font(.headline)) {
                        ForEach(0..<dessertDetails.strIngredients.count, id: \.self) { index in
                            HStack(spacing: 0) {
                                Text("\(dessertDetails.strIngredients[index])")
                                Spacer()
                                Text("\(dessertDetails.strMeasures[index])")
                            }
                        }
                    }
                    
                    Divider()
                    
                    Section(header: Text("Instructions").font(.headline)) {
                        Text(dessertDetails.strInstructions ?? "")
                            .padding(.vertical, 0)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                } else {
                    Text("Loading dessert details...")
                }
            }
            .padding()
            .navigationTitle(
                Text(dessert.strMeal)
            )
            .onAppear {
                fetchDessertDetails()
            }
        }
    }
    
    private func fetchDessertDetails() {
        guard let idMeal = dessert.idMeal, let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DessertDetailsResponse.self, from: data)
                if let dessertDetails = response.meals.first {
                    DispatchQueue.main.async {
                        self.dessertDetails = dessertDetails
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}



struct DessertDetailsResponse: Codable {
    let meals: [DessertDetails]
}

