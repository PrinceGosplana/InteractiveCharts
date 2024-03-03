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
                ForEach(appDownloads.sorted(by: { graphType == .bar ? false : $0.downloads > $1.downloads })) { download in
                    if graphType == .bar {
                        /// Bar Chart
                        BarMark(
                            x: .value("Month", download.month),
                            y: .value("Downloads", download.downloads)
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", download.month))
                    } else {
                        /// New API
                        /// Pie/Donut Chart
                        SectorMark(angle: .value("Downloads", download.downloads),
                                   innerRadius: .ratio(graphType == .donut ? 0.61 : 0),
                                   angularInset: graphType == .donut ? 6 : 1
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", download.month))
                    }
                        
                }
            }
            .chartLegend(position: .bottom, alignment: graphType == .bar ?.leading : .center, spacing: 25)
            .frame(height: 300)
            .padding(.top, 15)
            /// Adding animation
            .animation(.snappy, value: graphType)
            Spacer(minLength: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
