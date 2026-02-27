//
//  FilterModel.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 27/02/26.
//

import Foundation

enum SortOrder {
    case ascending
    case descending
}

class HealthListViewModel {
    
    var allEntries: [HealthDataModel] = []
    var filteredEntries: [HealthDataModel] = []
    
    func fetchData(){
        allEntries.removeAll()
        filteredEntries.removeAll()
        let data = CoreDataHelp.fetchMetricsData()
        for temp in data{
            let add = HealthDataModel(metricType: temp.metricType,metricValue: temp.metricValue,timestamp: temp.timestamp)
            allEntries.append(add)
            filteredEntries.append(add)
        }
       
    }
    
    func filterByTime(range: TimeRange) {
        filteredEntries = allEntries.filter {
            range.contains(date: $0.timestamp ?? Date())
        }
    }
    
    func applyFilters(range: TimeRange?,sortOrder:String="",metricType:String,filterType:String="All") {
        
        filteredEntries = allEntries
            .filter { $0.metricType == metricType }
        
        // Filter today
        if filterType != "All"{
            let calendar = Calendar.current
            filteredEntries = filteredEntries.filter {
                calendar.isDateInToday($0.timestamp ?? Date())
            }
        }
        
        // Filter by time range
        if let range = range {
            filteredEntries = filteredEntries.filter {
                range.contains(date: $0.timestamp ?? Date())
            }
        }
        
        // Sort
            switch sortOrder {
            case "ascending":
                filteredEntries.sort { $0.metricValue ?? 0 < $1.metricValue ?? 0 }
            case "descending":
                filteredEntries.sort { $0.metricValue ?? 0 > $1.metricValue ?? 0 }
            default:
                break
            }
    }
    
    func getRecentData(type: String) -> Double? {
        let filtered = allEntries
            .filter { $0.metricType == type }
            .sorted {
                ($0.timestamp ?? Date.distantPast) >
                ($1.timestamp ?? Date.distantPast)
            }
        
        return filtered.first?.metricValue
    }
}

