//
//  DateExtension.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import Foundation

extension Date {
    var dayNumberOfYear: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
    
    var longDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: self)
    }
    
}
