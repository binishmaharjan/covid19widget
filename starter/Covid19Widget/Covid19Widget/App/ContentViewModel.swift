//
//  ContentViewModel.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/12/03.
//

import Foundation

class ContentViewModel: ObservableObject {
    

    
    @Published var summary: Summary = .default
    @Published var isAnimating: Bool = false
    var selectedCountry: Country?
    
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
                }
            case .failure(let error):
                DispatchQueue.main.async { self?.isAnimating = false }
                print(error)
            }
        }
    }
    

}
