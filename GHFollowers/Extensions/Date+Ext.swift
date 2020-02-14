//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 14/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYear() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
