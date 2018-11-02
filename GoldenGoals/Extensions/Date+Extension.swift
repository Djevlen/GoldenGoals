//
//  Date+Extension.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 13/08/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import Foundation

extension Date{
    
    
    var today : String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }
}
