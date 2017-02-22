//
//  Int.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 20/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

extension Int {
    
    enum IntFormatType {
        case Currency
        case HoursAndMinutes
    }
    
}


extension Int {
    
    func format(as format: Int.IntFormatType) -> String? {
        switch format {
        
        case .Currency:
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            return formatter.string(from: NSNumber(value: self))
            
        case .HoursAndMinutes:
            
            let hours = self / 60
            let minutes = self % 60
            
            return "\(hours)h \(minutes)m"
        }
    }
}

