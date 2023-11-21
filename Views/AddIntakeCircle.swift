//
//  ProgressCircle.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI

struct AddIntakeCircle: View {
    
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
    // Slider Properties
    @Binding var intakeValue: CGFloat
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    
    var body: some View {
        
        VStack {
            // Progress Circle
            
            ZStack(alignment: .bottom, content: {
                Rectangle().fill(Color("liquid")).opacity(0.15)
                
                Rectangle().fill(Color("liquid")).frame(height: sliderHeight)
            })
            .frame(width: 280, height: maxHeight)
            .cornerRadius(10)
            // Container
            .overlay(
                Text("\(Int(intakeValue * 2500))mL")                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .cornerRadius(10)
                    .padding(.vertical, 30)
                    .offset(y: sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight + 105)
                
                ,alignment: .bottom
            )
            .padding(.vertical, 80)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ (value) in
                    
                    // getting drag a value
                    let translation = value.translation
                    
                    sliderHeight = -translation.height + lastDragValue
                    
                    // Limiting slider height value
                    
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
                    // Negative Height
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
                    // Updating progress
                    let progress = sliderHeight / maxHeight
                    
                    intakeValue = progress <= 1.0 ? progress : 1
                    
                }).onEnded({ (value) in
                    
                    // Limiting slider height value
                    
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
                    // Negative Height
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
                    // storing last drag value for restoration
                    lastDragValue = sliderHeight
                    
                }))
            
            // For test intake value
//            Text("Current Intake Value: \(intakeValue)")
//                .foregroundColor(.white)
//                .padding()
            
        }
    }
}

#Preview {
    AddIntakeCircle(intakeValue: .constant(0.0))
}
