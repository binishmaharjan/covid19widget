//
//  ContentView.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    @State var present: Bool = false
    
    var body: some View {
        ZStack {
            
            NavigationView {
                
                if present {
                    
                    NavigationLink(destination: SummaryView(stats: .from(viewModel.selectedCountry!)), isActive: $present) {
                        EmptyView()
                    }
                } else {
                    
                    List {
                        
                        NavigationLink(destination: SummaryView(stats: viewModel.globalStats)) {
                            CountryRow(stats: viewModel.globalStats)
                        }
                        
                        
                        ForEach(viewModel.summary.countries) { country in
                            
                            NavigationLink(destination: SummaryView(stats: .from(country))) {
                                CountryRow(stats: .from(country))
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Stats")
                    
                }
                
            } //: NavigationView
            
            ActivityIndicator(isAnimating: $viewModel.isAnimating)
                .padding(25)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.white)
                                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: 0.0, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                .opacity(viewModel.isAnimating ? 1 : 0))
            
        } //: ZStack
        .onOpenURL(perform: { url in
            let _country = viewModel.summary.countries.first { (country) -> Bool in
                country.name == url.absoluteString
            }
            
            guard let country = _country else { return }
            
            viewModel.selectedCountry = country
            present = true
        })
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
