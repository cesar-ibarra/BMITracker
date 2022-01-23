//
//  DoubleExtension.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import Foundation

extension Double {
    var toWeight: String {
        
        let weightFormatter = NumberFormatter()
        weightFormatter.usesGroupingSeparator = true
        
        weightFormatter.maximumFractionDigits = 2
        
        let weightString = weightFormatter.string(from: NSNumber(value: self))!
        
        return weightString
        
    }
    
    
}
