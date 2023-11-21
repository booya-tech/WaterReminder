//
//  HydrationModel.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/14/23.
//

import Foundation
import HealthKit

class HydrationModel: ObservableObject {
    
    @Published var date: Date
 
    @Published var goal: Int
    
    @Published var goalIndex: Int
    
    @Published var totalIntake: Int
    
    @Published var progress: Double
    
    // Intake entries (see WaterData.swift)
    @Published private(set) var intake:[WaterData] {
        // When modified, call the save function
        didSet {
            save()
        }
    }
    
    @Published var health: HealthModel
    
    init(healthModel: HealthModel) {
        // Default values (male intake)
        self.goalIndex = Constants.defaultValues.goalIndex
        self.goal = Constants.defaultValues.goal
        self.progress = 0.0
        self.totalIntake = 0
        self.health = healthModel
        self.date = Date()
        
        // Load existing array of entries (it not null)
        if let data = UserDefaults.standard.data(forKey: Constants.Config.saveKey) {
            if let decoded = try? JSONDecoder().decode([WaterData].self, from: data) {
                self.intake = decoded
            } else {
                self.intake = [WaterData]()
            }
        } else {
            self.intake = [WaterData]()
        }
        
        
        // Load last date (if not null) and compare
        if let dateData = UserDefaults.standard.data(forKey: Constants.Config.dateKey) {
            if let decodedDate = try? JSONDecoder().decode(Date.self, from: dateData) {
                
                // If the last date is not the same date as today, log the data
                if !Calendar.current.isDateInToday(decodedDate) {
                    self.health.saveData(intake: self.intake)
                    self.intake = [WaterData]()
                }
            }
        }
        
        // Load last date (if not null) and compare
        if let goalData = UserDefaults.standard.data(forKey: Constants.Config.goalKey) {
            if let decodedGoalIndex = try? JSONDecoder().decode(Int.self, from: goalData) {
                self.goalIndex = decodedGoalIndex
            }
        }
        
        self.updateData()
    }


    init(amounts: [Int]) {
        self.date = Date()
        self.goalIndex = Constants.defaultValues.goalIndex
        self.goal = Constants.defaultValues.goal
        self.progress = 0.0
        self.totalIntake = 0
        self.intake = [WaterData]()
        self.health = HealthModel()
        // Move the call to addIntake here, after all properties have been initialized
        for i in (0..<amounts.count) {
            self.addIntake(amount: Double(amounts[i]), drink: 0)
        }
    }

    
    // Save
    private func save() {
        if let encoded = try? JSONEncoder().encode(intake) {
            UserDefaults.standard.set(encoded, forKey: Constants.Config.saveKey)
        }
        
        if let encodedDate = try? JSONEncoder().encode(date) {
            UserDefaults.standard.set(encodedDate, forKey: Constants.Config.dateKey)
        }
        
        if let encodedGoalIndex = try? JSONEncoder().encode(goalIndex) {
            UserDefaults.standard.set(encodedGoalIndex, forKey: Constants.Config.goalKey)
        }
    }
    
    // Updates total intake and percentage
    private func updateTotal() {
        var total = 0
        for i in (0..<self.intake.count) {
            total += self.intake[i].amount
        }
        self.totalIntake = total
    }
    
    
    // Recalculates to progress double
    private func updateProgress() {
        self.progress = min(Double(totalIntake)/Double(goal), 1.0)
    }
    
    // Calls updateTotal and updateProgress
    private func updateData() {
        self.goal = self.goalIndex * Constants.Config.goalIncrement + Constants.Config.baseGoal
        self.updateTotal()
        self.updateProgress()
    }
    
    func addIntake(amount: Double, drink: Int) {
        self.intake.append(WaterData(amount: Int(amount), drink: drink))
        self.updateData()
    }
    
    func removeIntake(offset: IndexSet) {
        self.intake.remove(atOffsets: offset)
        self.updateData()
    }
    
    func logIntake() {
        // Save data to the healthModel first
        self.health.saveData(intake: self.intake)
        
        // Empty the intake
        self.intake = [WaterData]()
        self.updateData()
    }
    
    func saveGoal(index: Int) {
        self.goalIndex = index
        self.goal = self.goalIndex * Constants.Config.goalIncrement + Constants.Config.baseGoal
        updateData()
        save()
    }
    
}
