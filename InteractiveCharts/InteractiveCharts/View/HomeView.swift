//
//  HomeView.swift
//  InteractiveCharts
//
//  Created by OLEKSANDR ISAIEV on 29.02.2024.
//

import SwiftUI

struct HomeView: View {
    /// View Properties
    @State private var graphType: GraphType = .donut
    
    var body: some View {
        VStack {
            Picker("", selection: $graphType) {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
