//
//  CountryRow.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/12/03.
//

import SwiftUI

struct CountryRow: View {
    
    var stats: Stats
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(stats.name)
                    .fontWeight(.bold)
                
                
                HStack {
                    
                    Text("New Cases: \(stats.newConfirmed)")
                } //: HStack
                
            }//: VStack
            
            Spacer()
            
        }//: HStack
        .contentShape(Rectangle())
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(stats: .from(.default))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
