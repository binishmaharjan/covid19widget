//
//  CountryStatsView.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import SwiftUI

struct CountryStatsSmallView: View {
    let stats: CountryStats
    
    var body: some View {
        VStack() {
            TitleView(title: stats.last!.country,
                      lastUpdatedDate: stats.last!.date.toDisplayDate)
            
            InfoRowView(infos: [
                InfoData(title: "Active Cases", data: stats.last!.active.description),
                InfoData(title: "Total Cases", data: stats.last!.confirmed.description)
            ])
            
            Spacer()
        }
        .padding()
    }
}

struct CountryStatsMediumView: View {
    let stats: CountryStats
    
    var body: some View {
        
        VStack() {
            TitleView(title: stats.first!.country,
                      lastUpdatedDate: stats.first!.date)
            
            HStack{
                InfoRowView(infos: [
                    InfoData(title: "Active Cases", data: stats.last!.active.description),
                    InfoData(title: "Total Cases", data: stats.last!.confirmed.description)
                ])
                
                Spacer()
                
                InfoRowView(infos: [
                    InfoData(title: "Total Death", data: stats.last!.deaths.description),
                    InfoData(title: "Total Recovered", data: stats.last!.recovered.description)
                ])
            }
            Spacer()
        }
        .padding()
    }
}


