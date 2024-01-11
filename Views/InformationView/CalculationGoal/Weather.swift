//
//  Weather.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 12/8/23.
//

import Foundation

struct Weather: Identifiable, Hashable {
    var name: String
    var isFavorite: Bool
    let id = UUID()
    
    static func weatherExamples() -> [Weather] {
        return [
            Weather(name: "Hot", isFavorite: true),
            Weather(name: "Warm", isFavorite: true),
            Weather(name: "Cold", isFavorite: true)
        ]
    }
}
