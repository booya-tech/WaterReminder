//
//  CustomIntakeView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/10/23.
//

import SwiftUI

struct CustomIntakeView: View {
//    var hydration: HydrationModel
    
//    @Binding var intakeValue: CGFloat
    
    @State var amountIndex = 9
    
    // Boolean sheet view
    @State var addTodayViewSheet = false
    
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Custom intaking's number
            Picker(selection: $amountIndex, label: Text("Picker"), content: {
                ForEach(1..<51) { number in
                    Text("\(number * Constants.Config.intakeIncrementSlider) mL")
                }
            })
            .pickerStyle(WheelPickerStyle())
            .foregroundColor(.white)
            
            
            // Add & Save Intake Button
            Button(action: {
                
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Add Intake")
            })
            .buttonStyle(customButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
}

#Preview {
    CustomIntakeView()
}
