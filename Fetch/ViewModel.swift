//
//  ViewModel.swift
//  Fetch
//
//  Created by Tarush Tejas Rajput on 1/4/24.
//

import Foundation
import SwiftUI

struct Dessert: Hashable, Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String?
}

class ViewModel: ObservableObject {
    
    @Published var desserts: [Dessert] = []
    
    func fetch() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let response = try JSONDecoder().decode([String: [Dessert]].self, from: data)
                if let meals = response["meals"] {
                    DispatchQueue.main.async {
                        self.desserts = meals
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
