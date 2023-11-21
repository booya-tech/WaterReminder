//
//  CustomButtons.swift
//  HydrationApp
//
//  Created by Jesse Liu on 2021-06-01.
//  Description: Custom styles buttons used in the app
//

import Foundation
import SwiftUI


// Blue fade
struct customButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color("liquid"), Color("liquid")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.02 : 1.0)
    }
}


// Orange fade
struct secondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.pink.opacity(0.6)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.02 : 1.0)
    }
}
