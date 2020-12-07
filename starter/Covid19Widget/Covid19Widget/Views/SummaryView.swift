//
//  SummaryView.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/12/03.
//

import SwiftUI

struct SummaryView: View {
    
    var stats: Stats
    
    var body: some View {
        
        VStack(spacing: 4) {
            Text(stats.name)
                .font(.system(size: 30, weight: .bold))
            
            TrailingText(string: stats.date.toDisplayDate)
            
            Spacer()
                .frame(height: 12)
            
            HStack{
                InfoRowView(infos: [
                    InfoData(title: "New Cases", data: stats.newConfirmed.withComma),
                    InfoData(title: "Total Cases", data: stats.totalConfirmed.withComma)
                ])
                
                Spacer()
                
                InfoRowView(infos: [
                    InfoData(title: "New Death", data: stats.newDeaths.withComma),
                    InfoData(title: "Total Death", data: stats.totalDeaths.withComma)
                ])
            }//: HStackView
            
            InfoRowView(infos: [
                InfoData(title: "New Recovered", data: stats.newRecovered.withComma),
                InfoData(title: "Total Recovered", data: stats.totalRecovered.withComma)
            ])
            
            Spacer()
            
        }//: VStackView
        .padding(16)
        .navigationBarTitle("Summary", displayMode: .inline)
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(stats: .from(.default))
    }
}
