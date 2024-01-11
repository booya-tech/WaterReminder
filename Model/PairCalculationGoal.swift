//
//  PairCalculationGoal.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 1/8/24.
//

import Foundation

// Pairs value for calulate new goal
struct PairCalculationGoal: Identifiable, Hashable {
    var id: Int
    var name: String
    var value: Int
    
    init(id: Int, name: String, value: Int) {
        self.id = id
        self.name = name
        self.value = value
    }
}
