//
//  HomeView.swift
//  InteractiveCharts
//
//  Created by OLEKSANDR ISAIEV on 29.02.2024.
//

import Charts
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
            
            /// Charts
            Chart {
                ForEach(appDownloads) { download in
                    if graphType == .bar {
                        /// Bar Chart
                    } else {
                        /// New API
                        /// Pie/Donut Chart
                        SectorMark(angle: .value("Downloads", download.downloads),
                                   angularInset: 1)
                    }
                }
            }
            .frame(height: 300)
            .padding(.top, 15)
            
            Spacer(minLength: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
