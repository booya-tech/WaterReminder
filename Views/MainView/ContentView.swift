//
//  ContentView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    // Application uses 2 models
    private var health: HealthModel
    private var hydration: HydrationModel
    init() {
        health = HealthModel()
        hydration = HydrationModel(healthModel: health)
    }
    
    var body: some View {
        TodayView(hydration: hydration)
            .onAppear {
                
                health.requestAuthorization { success in
                    if !success {
                        print("Access not granted")
                    }
                }
                
                NotificationManager.instance.requestAutorization()
                
            }
    }
}

#Preview {
    ContentView()
}
