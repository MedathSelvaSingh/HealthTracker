//
//  TimeModel.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 27/02/26.
//

import Foundation
import UIKit

enum TimeRange: CaseIterable {
    case morning
    case afternoon
    case evening
    
    var title: String {
        switch self {
        case .morning: return "Morning"
        case .afternoon: return "Afternoon"
        case .evening: return "Evening"
        }
    }
    
    func contains(date: Date) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        
        switch self {
        case .morning:
            return hour >= 5 && hour < 12
        case .afternoon:
            return hour >= 12 && hour < 17
        case .evening:
            return hour >= 17 && hour <= 23
        }
    }
}
