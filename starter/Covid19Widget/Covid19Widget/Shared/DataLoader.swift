//
//  DataLoader.swift
//  Covid19Tracker
//
//  Created by Maharjan Binish on 2020/11/24.
//

import Foundation

struct DataLoader {
    
    static func fetchStats(for country: String, completion: @escaping (Result<CountryStats, Error>) -> Void) {
        let url = URL(string: "https://api.covid19api.com/country/\(country)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let countryData = try JSONDecoder().decode(CountryStats.self, from: data!)
                completion(.success(countryData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
