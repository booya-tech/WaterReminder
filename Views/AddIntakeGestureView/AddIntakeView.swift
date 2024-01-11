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
    @State var intakeValue: CGFloat = 0.1
    
    // presentationMode property used to close the sheet
    @Environment(\.presentationMode) var presentationMode
    
    // Beverage's type selection
    @State var drinkIndex = 0
    
    // 2 sheet views
    @State var addTodayViewSheet = false
    @State var customIntakeView = false
    
    
    @Binding var addIntakeSheet: Bool
    
    var body: some View {

        VStack {
            HStack {
                Spacer()
                Button(action: {
                    addIntakeSheet.toggle()
                }, label: {
                    Image(systemName: "x.circle.fill").resizable().frame(width: 32, height: 32).foregroundStyle(Color.white).opacity(0.5)
                })
            }.padding(.horizontal, 30)
            
            
            // Title
            Text("Add Intake").foregroundStyle(Color.white).font(.largeTitle).monospaced()
            
            
            AddIntakeCircle(intakeValue: $intakeValue).padding(.vertical, 40)
            
            
            HStack {
                
                // AI Detection btn - add-on (Wait for update)
//                Image("aiDetection-btn")
                
                // Add water intakes btn
                Button(action: {
                    hydration.addIntake(amount: Double(intakeValue) * Double(Constants.Config.intakeIncrementGesture), drink: drinkIndex)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("addWater-btn").padding(.horizontal, 45)
                })
                
                // Custom Amount btn - add-on (Wait for update)
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
    AddIntakeView(hydration: Constants.sampleModel, addIntakeSheet: .constant(true))
}
