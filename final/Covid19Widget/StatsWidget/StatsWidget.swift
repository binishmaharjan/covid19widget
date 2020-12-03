//
//  StatsWidget.swift
//  StatsWidget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), stats: .default)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), stats: .default)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
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

            let entry = SimpleEntry(date:currentDate, stats: stats)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))

            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let stats: CountryStats
}

struct EntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    let entry: SimpleEntry
    
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

@main
struct StatsWidget: Widget {
    let kind: String = "StatsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct StatsWidget_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(entry: SimpleEntry(date: Date(), stats: .default))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
