//
//  ReusableViews.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import SwiftUI

// MARK: Widget Title
struct TitleView: View {
    var title: String
    var lastUpdatedDate: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            TrailingText(string: lastUpdatedDate)
                .font(Font.system(size: 12))
            
            Spacer()
                .frame(height: 8)
        }
    }
}

// MARK: Widget Single Info View
struct InfoData: Hashable {
    let title: String
    let data: String
}

struct InfoView: View {
    let info: InfoData
    
    var body: some View {
        VStack {
            Text(info.data)
                .font(.headline)
            
            Text(info.title)
                .font(.subheadline)
                .padding(.bottom, 3)
        }
    }
}

struct InfoRowView: View {
    var infos: [InfoData]
    
    var body: some View {
        VStack {
            ForEach(infos, id: \.self) { info in
                InfoView(info: info)
            }
        }
    }
}

// MARK: Helper View
struct TrailingText: View {
    
    let string: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(string)
        }
    }
}

struct LeadingText: View {
    
    let string: String
    
    var body: some View {
        HStack {
            Text(string)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Spacer()
        }
    }
}
