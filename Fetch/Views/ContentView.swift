//
//  ContentView.swift
//  Fetch
//
//  Created by Tarush Tejas Rajput on 1/3/24.
//

import SwiftUI


// Content View of the app
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
                                .cornerRadius(8)
                                .padding(.vertical, 8)
                            
                            Text(dessert.strMeal)
                                .bold()
                                .padding(.vertical, 8)
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
