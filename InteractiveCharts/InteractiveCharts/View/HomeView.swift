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
                ForEach(GraphType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            
            Spacer(minLength: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
