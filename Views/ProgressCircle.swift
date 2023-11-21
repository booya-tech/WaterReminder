//
//  ProgressView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI

struct ProgressCircle: View {
    @State var sliderHeight: CGFloat = 0
    
    var complete: Bool
    var progress: Double

    var body: some View {

        ZStack {
            
            // If intakeValue has been completed, simply display a green circle
            if complete {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(1.0)
                    .foregroundColor(Color("icon"))
                    .shadow(color: .white, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                
            } else {
    
                // Background circle (lighter color)
                Circle()
                    .stroke(lineWidth: 15.0)
                    .opacity(0.3)
                    .foregroundColor(Color.blue)
                    .shadow(color: .blue, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                
                
                // Foreground circle (deeper color)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color("liquid"))
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear, value: self.progress)
                
                
            }
            
            // Data and graphics within the circle
            VStack(spacing: 0) {
                // let str = NSString(format:"%d , %f, %ld, %@", INT_VALUE, FLOAT_VALUE, LONG_VALUE, STRING_VALUE)
                HStack {
                    // max 100% by 1.0 progressValue
                    Text(String(format: "%.0f%%", min(self.progress, 1.0) * 100.0))
                        .font(Font.custom("NerkoOne-Regular", size: 36))
                        .bold()
                    Image(systemName: "drop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                }
                Text("of daily goal")
                    .font(Font.custom("NerkoOne-Regular", size: 16))
            }
            .padding()
        }
    }
}

#Preview {
    ProgressCircle(complete: false, progress: 0.8)
}
