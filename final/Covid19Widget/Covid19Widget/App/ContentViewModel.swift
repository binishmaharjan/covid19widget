//
//  ContentViewModel.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/12/03.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    enum StatsSelectionType {
        case global
        case country(Country)
    }
    
    @Published var summary: Summary = .default
    @Published var isAnimating: Bool = false
    @Published var currentStats: Stats = Stats.from(.default)
    
    var globalStats: Stats {
        .from(summary.global, date: summary.date)
    }
    
    init() {
        fetchSummary()
    }
    
    func fetchSummary() {
        
        isAnimating = true
        
        DataLoader.fetchSummary { [weak self] (result) in
            switch result {
    
            case .success(let summary):
                DispatchQueue.main.async {
                    self?.isAnimating = false
                    self?.summary = summary
                    self?.currentStats = .from(summary.global, date: summary.date)
                }
            case .failure(let error):
                DispatchQueue.main.async { self?.isAnimating = false }
                print(error)
            }
        }
    }
    
    func changeCurrentStats(for selection: StatsSelectionType) {
        switch selection {
        
        case .global:
            currentStats = globalStats
        case .country(let country):
            currentStats = .from(country)
        }
    }
}
