//
//  SettingsView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI

struct SettingsView: View {
    @State var existingIndex: Int
    
    @ObservedObject var hydration: HydrationModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Settings").font(.largeTitle).bold().padding(.top, 50)
            
            Text("Set your goal:")
            
            Spacer()
            
            VStack {
                // Custom goal's number
                Picker(selection: $existingIndex, label: Text("Picker"), content: {
                    ForEach(0..<42) { number in
                        Text("\(number * 100 + 2000) mL")
                    }
                })
                .pickerStyle(WheelPickerStyle())
                .foregroundColor(.white)
                
                // Add & Save Intake Button
                Button(action: {
                    // See at HydrationModel.swift
                    hydration.saveGoal(index: existingIndex)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("Save Goal")
                        Image(systemName: "square.and.arrow.down.fill")
                        
                    }.frame(width: 150, height: 10)
                    
                })
                .padding(.bottom)
                .buttonStyle(customButtonStyle())
                
                
                // Save log to Apple's Health
                Button(action: {
                    hydration.logIntake()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("Log to Health")
                        Image(systemName: "heart.square.fill")
                        
                    }.frame(width: 150, height: 10)
                }).buttonStyle(secondaryButtonStyle())
                
                Spacer()
                
                // Information box for logging
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("icon"))
                        .cornerRadius(15)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .opacity(0.1)
                    
                    Text("Logging to health deletes all intake listings from this app! Intake is logged and reset automatically at the start of each day")
                        .font(.caption)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .frame(width: 350, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
        }.background(Color("background")).foregroundColor(.white)
    }
}

#Preview {
    SettingsView(existingIndex: 17, hydration: Constants.sampleModel)
}
