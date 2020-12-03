//
//  SummaryStats.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/12/03.
//

import Foundation

struct Summary: Codable {
    let message: String
    let global: Global
    let countries: [Country]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case global = "Global"
        case countries = "Countries"
        case date = "Date"
    }
    
    static var `default`: Summary = .init(message: "",
                                               global: .default,
                                               countries: [.default],
                                               date: "0000-00-00T00:00:00Z")
}


struct Global: Codable {
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int

    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
    
    static var `default`: Global = .init(newConfirmed: 0,
                                         totalConfirmed: 0,
                                         newDeaths: 0,
                                         totalDeaths: 0,
                                         newRecovered: 0,
                                         totalRecovered: 0)
}

struct Country: Codable, Identifiable {
    var id: UUID = UUID()
    let name, countryCode, slug: String
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int
    let date: String

    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case countryCode = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case date = "Date"
    }
    
    static var `default`: Country = .init(name: "XXXXXX",
                                          countryCode: "XXX",
                                          slug: "XXX",
                                          newConfirmed: 0,
                                          totalConfirmed: 0,
                                          newDeaths: 0,
                                          totalDeaths: 0,
                                          newRecovered: 0,
                                          totalRecovered: 0,
                                          date: "0000-00-00T00:00:00Z")
}

struct Stats: Identifiable {
    var id: UUID = UUID()
    let name, countryCode: String
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int
    let date: String
    
    
    static func from(_ country: Country) -> Stats {
        .init(name: country.name,
              countryCode: country.countryCode,
              newConfirmed: country.newConfirmed,
              totalConfirmed: country.totalConfirmed,
              newDeaths: country.newDeaths,
              totalDeaths: country.totalDeaths,
              newRecovered: country.newRecovered,
              totalRecovered: country.totalRecovered,
              date: country.date)
    }
    
    static func from(_ global: Global, date: String) -> Stats {
        .init(name: "Global",
              countryCode: "-",
              newConfirmed: global.newConfirmed,
              totalConfirmed: global.totalConfirmed,
              newDeaths: global.newDeaths,
              totalDeaths: global.totalDeaths,
              newRecovered: global.newRecovered,
              totalRecovered: global.totalRecovered,
              date: date)
    }
}
