//
//  RemoteImageModel.swift
//  Fetch
//
//  Created by Tarush Tejas Rajput on 1/4/24.
//

import Foundation
import SwiftUI

// Remote image view
struct RemoteImage: View {
    let url: String
    
    @State private var imageData: Data? = nil
    
    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
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
