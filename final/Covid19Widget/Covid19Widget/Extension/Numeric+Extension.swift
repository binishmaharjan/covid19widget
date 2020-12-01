//
//  Numeric+Extension.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import Foundation

extension Int {
    
    var withComma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: self)
    }
}

extension NumberFormatter {
    
    func string(from value: Int) -> String {
        string(from: NSNumber(value: value))!
    }
}
