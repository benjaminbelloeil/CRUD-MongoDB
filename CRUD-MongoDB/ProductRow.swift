//
//  ProductRow.swift
//  CRUD-MongoDB
//
//  Created by Benjamin Belloeil on 9/21/24.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    let onDelete: () -> Void // Callback function to handle delete action
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Main card content
            HStack(spacing: 16) {
                Image(systemName: "cube.box.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .shadow(color: Color.blue.opacity(0.2), radius: 6, x: 0, y: 4)
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    // Product Name
                    Text(product.productName)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    // Product Details (One Below the Other)
                    Text("**ID:** \(product.productId)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("**Category:** \(product.category)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("**On Hand:** \(product.onHand)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("**Cost:** $\(String(format: "%.2f", product.cost))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
            
            // Trash Can Button (Top Right) with smaller size and more transparent background
            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Circle().fill(Color.red.opacity(0.6))) // Reduced opacity
            }
            .padding([.top, .trailing], 8)
        }
    }
}
