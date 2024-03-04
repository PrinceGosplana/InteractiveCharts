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
    /// Chart selection
    @State private var barSelection: String?
    @State private var pieSelection: Double?
    
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
            
            if let highestDownloads = appDownloads.max(by: { $1.downloads > $0.downloads }) {
                ChartPopOverView(highestDownloads.downloads, highestDownloads.month, true)
                    .padding(.vertical)
                    .opacity(barSelection == nil ? 1 : 0)
            }
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
                
                if let barSelection {
                    RuleMark(x: .value("Month", barSelection))
                        .foregroundStyle(.gray.opacity(0.35))
                        .zIndex(-10)
                        .offset(yStart: -10)
                        .annotation(overflowResolution: .init(x: .fit, y: .disabled)) {
                            if let downloads = appDownloads.findDownloads(barSelection) {
                                ChartPopOverView(downloads, barSelection)
                            }
                        }
                }
            }
            .chartXSelection(value: $barSelection)
            .chartAngleSelection(value: $pieSelection)
            .chartLegend(position: .bottom, alignment: graphType == .bar ?.leading : .center, spacing: 25)
            .frame(height: 300)
            .padding(.top, 10)
            /// Adding animation
            .animation(graphType == .bar ? .none : .snappy, value: graphType)
            Spacer(minLength: 0)
        }
        .padding()
        .onChange(of: pieSelection, initial: false) { oldValue, newValue in
            
        }
    }
    
    /// Chart Popover view
    @ViewBuilder
    func ChartPopOverView(_ downloads: Double, _ month: String, _ isTitleView: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(isTitleView ? "Highest" : "App") Downloads")
                .font(.title3)
                .foregroundStyle(.gray)
            
            HStack(spacing: 4) {
                Text(String(format: "%.0f", downloads))
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(month)
                    .font(.title3)
                    .textScale(.secondary)
            }
        }
        .padding(isTitleView ? [.horizontal] : [.all])
        .background(Color("PopupColor").opacity(isTitleView ? 0 : 1), in: .rect(cornerRadius: 8))
        .frame(maxWidth: .infinity, alignment: isTitleView ? .leading : .center)
    }
}

#Preview {
    ContentView()
}
