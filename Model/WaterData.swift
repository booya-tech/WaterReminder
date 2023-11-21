//
//  WaterData.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import Foundation

// Water data for a single day
struct WaterData: Identifiable, Codable {
    var amount:Int
    var drinkID:Int
    var date:Date
    var id:UUID?
    
    init(amount:Int, drink: Int) {
        self.amount = amount
        self.drinkID = drink
        self.date = Date()
        self.id = UUID()
    }
}
