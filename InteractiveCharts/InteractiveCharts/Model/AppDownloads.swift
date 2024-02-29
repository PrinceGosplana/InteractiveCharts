//
//  AppDownloads.swift
//  InteractiveCharts
//
//  Created by OLEKSANDR ISAIEV on 29.02.2024.
//

import SwiftUI

struct AppDownloads: Identifiable {
    var id: UUID = .init()
    var date: Date
    var downloads: Double
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
}

extension [AppDownloads] {
    func findDownloads(_ on: String) -> Double? {
        if let download = self.first(where: { $0.month == on }) {
            return download.downloads
        }
        return nil
    }
    
    func index(_ on: String) -> Int {
        if let index = self.firstIndex(where: { $0.month == on }) {
            return index
        }
        return 0
    }
}
