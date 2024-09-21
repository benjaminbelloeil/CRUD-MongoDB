//
//  ProductListView.swift
//  CRUD-MongoDB
//
//  Created by Benjamin Belloeil on 9/21/24.
//

import SwiftUI

struct ProductListView: View {
    @Environment(ProductsModel.self) var productsModel
    @State private var showingAddProduct = false
    @State private var productToEdit: Product?
    @State private var showingDeleteConfirmation = false
    @State private var productToDelete: Product?
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                if productsModel.products.isEmpty && !isLoading {
                    VStack {
                        Image(systemName: "cart")
                            .font(.system(size: 64))
                            .foregroundColor(.gray)
                        Text("No products available")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(productsModel.products) { product in
                                ProductRow(product: product, onDelete: {
                                    productToDelete = product
                                    showingDeleteConfirmation = true
                                })
                                .onTapGesture {
                                    productToEdit = product
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.top, 16)
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar {
                Button(action: {
                    showingAddProduct = true
                }) {
                    Label("Add Product", systemImage: "plus")
                        .font(.title2)
                }
            }
            .alert(isPresented: $showingDeleteConfirmation) {
                Alert(
                    title: Text("Delete Product"),
                    message: Text("Are you sure you want to delete this product?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let productToDelete = productToDelete {
                            deleteProduct(productToDelete)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .sheet(isPresented: $showingAddProduct) {
                NavigationView {
                    ProductDetailView(mode: .add, product: Product.defaultProduct)
                }
            }
            .sheet(item: $productToEdit) { product in
                NavigationView {
                    ProductDetailView(mode: .edit, product: product)
                }
            }
        }
        .onAppear {
            Task {
                await fetchProducts()
            }
        }
    }
    
    private func fetchProducts() async {
        isLoading = true
        await productsModel.fetchProducts()
        isLoading = false
    }
    
    private func deleteProduct(_ product: Product) {
        Task {
            do {
                try await productsModel.deleteProduct(product: product)
            } catch {
                errorMessage = "Failed to delete product: \(error.localizedDescription)"
            }
        }
    }
}
