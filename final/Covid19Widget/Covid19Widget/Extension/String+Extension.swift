//
//  String+Extension.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import Foundation

extension String {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    var toDisplayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        return dateFormatter.string(from: self.toDate)
    }
}
