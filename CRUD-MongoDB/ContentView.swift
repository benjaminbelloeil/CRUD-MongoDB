//
//  ContentView.swift
//  CRUD-MongoDB
//
//  Created by Benjamin Belloeil on 9/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var productsModel = ProductsModel()
    
    var body: some View {
        ProductListView()
            .environment(productsModel)
    }
}

#Preview {
    ContentView()
}
