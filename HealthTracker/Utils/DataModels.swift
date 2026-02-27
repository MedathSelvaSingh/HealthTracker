//
//  DataModels.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import Foundation

struct HealthDataModel:Codable{
    var metricType:String?
    var metricValue:Double?
    var timestamp:Date?
}


