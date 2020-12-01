//
//  CountryStats.swift
//  Covid19Tracker
//
//  Created by Maharjan Binish on 2020/11/24.
//

import Foundation

struct Covid19Stats: Codable {
    
    let country: String
    let confirmed, deaths, recovered, active: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}

typealias CountryStats = [Covid19Stats]

extension Covid19Stats {
    
    static let `default`:Covid19Stats = .init(country: "XXX", confirmed: 0, deaths: 0, recovered: 0, active: 0, date: "0000-00-00T00:00:00Z")
}

extension CountryStats {
    
    static let `default`:CountryStats = [ .default ]
}
