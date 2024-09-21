//
//  ProductDetailView.swift
//  CRUD-MongoDB
//
//  Created by Benjamin Belloeil on 9/17/24.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(ProductsModel.self) var productsModel
    @Environment(\.dismiss) var dismiss
    
    var mode: Mode
    @State var product: Product
    @State private var isProcessing = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Product ID", text: $product.productId)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .disabled(mode == .edit)  // Disable editing the ID in edit mode
                
                TextField("Product Name", text: $product.productName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                TextField("Category", text: $product.category)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                TextField("Cost", value: $product.cost, formatter: NumberFormatter())
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                TextField("On Hand", value: $product.onHand, formatter: NumberFormatter())
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Button(action: processProduct) {
                    Text(mode == .add ? "Add Product" : "Update Product")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isProcessing ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                }
                .disabled(isProcessing)
                
                if isProcessing {
                    ProgressView("Processing...")
                        .padding(.top, 20)
                }
            }
            .padding()
        }
        .navigationTitle(mode == .add ? "Add Product" : "Edit Product")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Message"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                if alertMessage.contains("successfully") {
                    dismiss()
                }
            })
        }
    }
    
    private func processProduct() {
        isProcessing = true
        Task {
            do {
                if mode == .add {
                    try await productsModel.addProduct(product: product)
                    alertMessage = "Product added successfully"
                } else {
                    try await productsModel.updateProduct(product: product)
                    alertMessage = "Product updated successfully"
                }
                showAlert = true
            } catch {
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
            }
            isProcessing = false
        }
    }
}
