//
//  ProductsModel.swift
//  CRUD-MongoDB
//
//  Created by Benjamin Belloeil on 9/17/24.
//
import SwiftUI

@Observable
class ProductsModel {
    var products: [Product] = []
    
    func fetchProducts() async {
        products.removeAll()
        let url = URL(string: "http://192.168.86.20:4000/products")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedResponse = try? JSONDecoder().decode([Product].self, from: data) {
                products = decodedResponse
            }
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    func addProduct(product: Product) async throws {
        let url = URL(string: "http://192.168.86.20:4000/add-product")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(product)

        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        await fetchProducts()  // Refresh the product list
    }

    func updateProduct(product: Product) async throws {
        let url = URL(string: "http://192.168.86.20:4000/update-product/\(product.productId)")!

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(product)

        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        await fetchProducts()  // Refresh the product list
    }

    func deleteProduct(product: Product) async throws {
        let url = URL(string: "http://192.168.86.20:4000/delete-product/\(product.productId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.timeoutInterval = 10
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        switch httpResponse.statusCode {
        case 200:
            await fetchProducts()  // Refresh the product list
        case 404:
            if let errorResponse = try? decoder.decode([String: String].self, from: data),
               let errorMessage = errorResponse["error"] {
                throw NSError(domain: "ServerError", code: 404, userInfo: ["message": errorMessage])
            } else {
                throw NSError(domain: "ServerError", code: 404, userInfo: ["message": "Product not found"])
            }
        default:
            if let errorResponse = try? decoder.decode([String: String].self, from: data),
               let errorMessage = errorResponse["error"] {
                throw NSError(domain: "ServerError", code: httpResponse.statusCode, userInfo: ["message": errorMessage])
            } else {
                throw URLError(.badServerResponse)
            }
        }
    }
}


