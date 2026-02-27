//
//  CoreDataHelper.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 26/02/26.
//

import Foundation
import CoreData
import UIKit


enum MetricType: String, CaseIterable {
    case heartRate
    case steps
    case sleep
    case cholesterol
    case bodyTemperature
    case bloodPressure
}

class CoreDataHelp{
    
    public static func addOrUpdateMetric(type: String,
                                         value: Double,
                                         date: Date) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )
        
        let normalizedDate = calendar.date(from: components)!
        
        let fetchRequest: NSFetchRequest<HealthData> = HealthData.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "timestamp == %@ AND metricType == %@",
            normalizedDate as NSDate,
            type
        )
        
        do {
            let results = try context.fetch(fetchRequest)
            
            let entry = results.first ?? HealthData(context: context)
            
            if entry.id == nil {
                entry.id = UUID()
            }
            
            entry.timestamp = normalizedDate
            entry.metricType = type
            entry.metricValue = value
            
            try context.save()
            
        } catch {
            print("Save error: \(error)")
        }
    }
    
    public static func addMetrics(data:HealthDataModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newData = HealthData(context: context)
       
        newData.timestamp = data.timestamp
        
        do {
            try context.save()
            print("Data saved successfully!")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    public static func fetchMetricsData() -> [HealthData] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<HealthData> = HealthData.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return []
        }
    }
}
