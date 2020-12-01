//
//  CountryStats.swift
//  Covid19Tracker
//
//  Created by Maharjan Binish on 2020/11/24.
//

import Foundation

//struct Country: Decodable {
//    let country: String
//    let countryAbbreviation: String
//    let totalCases: String
//    let newCases: String
//    let totalDeaths: String
//    let newDeaths: String
//    let totalRecovered: String
//    let activeCases: String
//    let seriousCritical: String
//    let casesPerMillPop: String
//    let flag: String
//
//    enum CodingKeys: String, CodingKey {
//        case country
//        case countryAbbreviation = "country_abbreviation"
//        case totalCases = "total_cases"
//        case newCases = "new_cases"
//        case totalDeaths = "total_deaths"
//        case newDeaths = "new_deaths"
//        case totalRecovered = "total_recovered"
//        case activeCases = "active_cases"
//        case seriousCritical = "serious_critical"
//        case casesPerMillPop = "cases_per_mill_pop"
//        case flag
//    }
//
//    static var `default`: Country = Country(country: "Country",
//                                            countryAbbreviation: "XX",
//                                            totalCases: "N/A",
//                                            newCases: "N/A",
//                                            totalDeaths: "N/A",
//                                            newDeaths: "N/A",
//                                            totalRecovered: "N/A",
//                                            activeCases: "N/A",
//                                            seriousCritical: "N/A",
//                                            casesPerMillPop: "N/A",
//                                            flag: "https://www.worldometers.info/img/flags/ja-flag.gif")
//}
//
//struct CountryStats: Decodable {
//    var lastUpdated: String = ""
//    var status: String = ""
//    var countries: [Country] = [Country]()
//
//    private enum MainKeys: String, CodingKey {
//        case data
//        case status
//    }
//
//    private enum DataKeys: String, CodingKey {
//        case lastUpdated = "last_update"
//        case countries = "rows"
//    }
//
//    static var `default`: CountryStats = CountryStats(lastUpdated: "XXX, 00 0000, 00:00, UTC",
//                                                                      status: "success",
//                                                                      countries: [Country.default])
//}
//
//extension CountryStats {
//    init(from decoder: Decoder) throws {
//        if let mainContainer = try? decoder.container(keyedBy: MainKeys.self) {
//            if let dataContainer = try? mainContainer.nestedContainer(keyedBy: DataKeys.self, forKey: .data) {
//                self.lastUpdated = try dataContainer.decode(String.self, forKey: .lastUpdated)
//
//                self.countries = try dataContainer.decode([Country].self, forKey: .countries)
//            }
//
//            self.status = try mainContainer.decode(String.self, forKey: .status)
//        }
//    }
//}

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
