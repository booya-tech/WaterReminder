//
//  AddIntakeView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI
import UIKit

struct AddIntakeView: View {
    
    var hydration: HydrationModel
    
//    @Binding var addIntakeCircle: AddIntakeCircle
    @State var intakeValue: CGFloat = 0.0
    
    // presentationMode property used to close the sheet
    @Environment(\.presentationMode) var presentationMode
    
    // Beverage's type selection
    @State var drinkIndex = 0
    
    // Boolean for 2 sheets view
    @State var addTodayViewSheet = false
    @State var customIntakeView = false
    
    var body: some View {
        
        VStack {
            Text("Add Intake").foregroundStyle(Color.white).font(.largeTitle).monospaced()
            AddIntakeCircle(intakeValue: $intakeValue)
            
            HStack {
                // AI Detection btn - add-on
//                Image("aiDetection-btn")
                
                // Add water intakes btn
                Button(action: {
                    hydration.addIntake(amount: Double(intakeValue) * Double(Constants.Config.intakeIncrementGesture), drink: drinkIndex)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("addWater-btn").padding(.horizontal, 45)
                })
                
                // Custom Amount btn - add-on
//                Button(action: {
//                    customIntakeView.toggle()
//                }, label: {
//                    Image("customIntake-btn")
//                })
//                .sheet(isPresented: $customIntakeView, content: {
//                    CustomIntakeView()
//                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
        .ignoresSafeArea()
        
    }
}

#Preview {
    AddIntakeView(hydration: Constants.sampleModel)
}
