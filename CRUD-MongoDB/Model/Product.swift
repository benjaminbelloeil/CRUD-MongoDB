//
//  Product.swift
//  CRUD-MongoDB
//
//  Created by Benjamin Belloeil on 9/17/24.
//

import SwiftUI

struct Product: Identifiable, Codable {

    var id: String
    var productId: String
    var productName: String
    var category: String
    var cost: Double
    var onHand: Int

    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case productName = "product_name"
        case category
        case cost
        case onHand = "on_hand"
    }
    
    // init(from decoder: Decoder) throws {
    //     let container = try decoder.container(keyedBy: CodingKeys.self)
    //     id = try container.decode(String.self, forKey: .id)
    //     productId = try container.decode(String.self, forKey: .productId)
    //     productName = try container.decode(String.self, forKey: .productName)
    //     cost = try container.decode(Double.self, forKey: .cost)
    //     onHand = try container.decode(Int.self, forKey: .onHand)
    // }
    
    // func encode(to encoder: Encoder) throws {
    //     var container = encoder.container(keyedBy: CodingKeys.self)
    //     try container.encode(id, forKey: .id)
    //     try container.encode(productId, forKey: .productId)
    //     try container.encode(productName, forKey: .productName)
    //     try container.encode(cost, forKey: .cost)
    //     try container.encode(onHand, forKey: .onHand)
    // }
}

extension Product {
    
    static var defaultProduct = Product(id: "", productId: "", productName: "", category: "", cost: 0, onHand: 0)
    
}
