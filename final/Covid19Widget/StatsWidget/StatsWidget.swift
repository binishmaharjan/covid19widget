//
//  StatsWidget.swift
//  StatsWidget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import WidgetKit
import SwiftUI

/// Timeline Provider
struct CountryStatsTimelineProvider: TimelineProvider {

    typealias Entry = CountryStatsEntry
    
    // Placeholder
    func placeholder(in context: Context) -> CountryStatsEntry {
        CountryStatsEntry(date: Date(), stats: .default)
    }
    
    /// Snaphot
    func getSnapshot(in context: Context, completion: @escaping (CountryStatsEntry) -> Void) {
        let entry = CountryStatsEntry(date: Date(), stats: .default)
        completion(entry)
    }
    
    // Timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<CountryStatsEntry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60 * 24, to: currentDate)!
        
        DataLoader.fetchStats(for: "japan") { (result) in
            let stats: CountryStats
            switch result {
            case .success(let fetchedData):
                stats = fetchedData
            case .failure:
                stats = .default
            }

            let entry = CountryStatsEntry(date:currentDate, stats: stats)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))

            completion(timeline)
        }
    }
    
}

/// TimelineEntry
struct CountryStatsEntry: TimelineEntry {
    public let date: Date
    public let stats: CountryStats
}

/// Widget View
struct CountryStatsEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    let entry: CountryStatsEntry
    
    var stats: Covid19Stats {
        entry.stats.last ?? .default
    }
    
    var body: some View {
        switch family {
        case .systemSmall:
            VStack() {
                TitleView(title: stats.country,
                          lastUpdatedDate: stats.date.toDisplayDate)
                
                InfoRowView(infos: [
                    InfoData(title: "Active Cases", data: stats.active.withComma),
                    InfoData(title: "Total Cases", data: stats.confirmed.withComma)
                ])
                
                Spacer()
            }
            .padding()
        default:
            VStack() {
                TitleView(title: stats.country,
                          lastUpdatedDate: stats.date.toDisplayDate)
                
                HStack{
                    InfoRowView(infos: [
                        InfoData(title: "Active Cases", data: stats.active.withComma),
                        InfoData(title: "Total Cases", data: stats.confirmed.withComma)
                    ])
                    
                    Spacer()
                    
                    InfoRowView(infos: [
                        InfoData(title: "Total Death", data: stats.deaths.withComma),
                        InfoData(title: "Total Recovered", data: stats.recovered.withComma)
                    ])
                }
                Spacer()
            }
            .padding()
        }
    }
}

/// Widget
@main
struct StatsWidget: Widget {
    let kind: String = "StatsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CountryStatsTimelineProvider()) { entry in
            CountryStatsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

/// Preview
struct StatsWidget_Previews: PreviewProvider {
    static var previews: some View {
        CountryStatsEntryView(entry: CountryStatsEntry(date: Date(), stats: .default))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
