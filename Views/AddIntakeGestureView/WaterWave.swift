//
//  WaterWave.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 1/10/24.
//

import Foundation
import SwiftUI

struct WaterWave: Shape {
    
    var intakeValue: CGFloat
    
    // Wave Height
    var waveHeight: CGFloat
    
    // Initial Animation Start
    var offset: CGFloat
    
    // Enabling Animation
    var animatableData: CGFloat {
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            
            path.move(to: .zero)
            
            // MARK: - Drawing Waves using Sine
            let progressHeight: CGFloat = (1 - intakeValue) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
                
                // Bottom Portion
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
            }
            
        }
        
    }
}
