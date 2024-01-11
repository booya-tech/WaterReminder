//
//  Constants.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/11/23.
//

import Foundation
import SwiftUI


struct Constants {
    
    // Dummy model
    static var sampleModel = HydrationModel(amounts: [1100, 200, 300])
    
    // Drink type names
    static let drinks = ["Water", "Coffee", "Juice", "Other"]
    
    // Drink type colors
    static let drinkColors = [Color.blue, Color("coffee"), Color.orange, Color.gray]
    
//    Calculation Component (weight only has one value not the same as others including gender, activity, and weather)
    static let weights = 30...400
    
    // Configuration Constants
    struct Config {
        // UserDefaults Keys
        static let saveKey = "key"
        static let dateKey = "date"
        static let goalKey = "goal"
        
        // Slider increments
        static let intakeIncrementGesture = 1000
        static let intakeIncrementSlider = 50
        static let goalIncrement = 100
        static let baseGoal = 2000
    }
    
    // Default values
    struct defaultValues {
        // Default amounts for men's intake
        static let goalIndex = 17
        static let goal = goalIndex * Constants.Config.goalIncrement + Constants.Config.baseGoal
        
    }
    
}
