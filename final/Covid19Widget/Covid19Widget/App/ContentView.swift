//
//  ContentView.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        ZStack {
            
            NavigationView {
                
                VStack {
                    SummaryView(stats: viewModel.currentStats)
                        .padding(24)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.white)
                                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: 0.0, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                        .padding(16))

                    List {
                        
                        CountryRow(stats: viewModel.globalStats)
                            .onTapGesture() {
                                viewModel.changeCurrentStats(for: .global)
                            }

                        ForEach(viewModel.summary.countries) { country in
                            CountryRow(stats: .from(country))
                                .onTapGesture() {
                                    viewModel.changeCurrentStats(for: .country(country))
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                } //:VStack
                .navigationTitle("Stats")
                
            } //: NavigationView
            
            ActivityIndicator(isAnimating: $viewModel.isAnimating)
                .padding(25)
                .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.white)
                                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: 0.0, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                .opacity(viewModel.isAnimating ? 1 : 0))
            
        } //: ZStack
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
