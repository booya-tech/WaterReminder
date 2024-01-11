//
//  ProgressCircle.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI

struct AddIntakeCircle: View {
    
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
    // Slider properties
    @Binding var intakeValue: CGFloat
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    @State var startAnimation: CGFloat = 0
    
    var body: some View {
        
        VStack {
            // MARK: - Wave Form
            GeometryReader { proxy in
                
                let size = proxy.size
                
                
                // MARK: - Water Drop
                ZStack {
                    // Add container behind the circle
//                    Circle()
//                        .stroke(lineWidth: 2.8)
//                        .foregroundStyle(Gradient(colors: [Color.gray, Color.gray, Color.white]))
//                        .padding(20)
                    
                    // Wave Form Shape
                    WaterWave(intakeValue: intakeValue, waveHeight: 0.1, offset: startAnimation)
                        .fill(Color("liquid"))
                        .frame(width: size.width, height: size.height, alignment: .center)
                        .onAppear {
                            // Looping Animation
                            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                
                                startAnimation = size.width
                                
                            }
                        }
                    // Water Drops
                        .overlay(content: {
                            ZStack {
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -20)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: 40, y:30)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 25)
                                    .offset(x: -30, y: 80)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x: 50, y: 70)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: 40, y: 100)
                                
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: -40, y: 50)
                            }
                        })
                    // Masking into Drop Shape
                        .mask {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                        }
                    // Display intake value by user's gesture
                        .overlay {
                            Text("\(Int(intakeValue * 1000))mL")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 18)
                                .cornerRadius(10)
                                .padding(.vertical, 30)
                                .offset(y: sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight + 105)
                                .animation(.none)
                            
                        }
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ (value) in
                                
                                // getting drag a value
                                let translation = value.translation
                                
                                sliderHeight = -translation.height + lastDragValue
                                
                                // Limiting slider height value
                                sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                                
                                // Negative Height
                                sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                                
                                // Updating intakeValue
                                // Calculate intakeValue based on 10 mL steps
                                let stepSize: CGFloat = 10.0
                                let progress = sliderHeight / maxHeight
                                let intakeInMl = round(progress * 1000 / stepSize) * stepSize
                                intakeValue = intakeInMl / 1000
                                
                                
                                
                            }).onEnded({ (value) in
                                
                                // Limiting slider height value
                                sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                                
                                // Negative Height
                                sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                                
                                // storing last drag value for restoration
                                lastDragValue = sliderHeight
                                
                            }))
                }
                
                
                
                
            }
            .frame(height: 350)
            // Display intake value by user's gesture
            //            Text("\(Int(intakeValue * 1000))mL").font(.title)
            //                .foregroundStyle(Color.white)
            //                .animation(.none)
            
        }
        .padding()
        
    }
}

// Old IntakeCircle version
//struct AddIntakeCircle: View {
//
//    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
//
//    // Slider Properties
//    @Binding var intakeValue: CGFloat
//    @State var sliderHeight: CGFloat = 0
//    @State var lastDragValue: CGFloat = 0
//
//
//    var body: some View {
//
//        VStack {
//
//            // Progress Circle
//            ZStack(alignment: .bottom, content: {
//                Rectangle()
//                    .fill(Color("liquid"))
//                    .opacity(0.15)
//
//                Rectangle()
//                    .fill(Color("liquid"))
//                    .frame(height: sliderHeight)
//            })
//            .frame(width: 280, height: maxHeight)
//            .cornerRadius(10)
//            // Container - The fluid's value for binding data => intakeValue
//            .overlay(
//                Text("\(Int(intakeValue * 1000))mL")
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 18)
//                    .cornerRadius(10)
//                    .padding(.vertical, 30)
//                    .offset(y: sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight + 105)
//
//                ,alignment: .bottom
//            )
//            .padding(.vertical, 80)
//            .clipShape(Circle())
//            .gesture(DragGesture(minimumDistance: 0)
//                .onChanged({ (value) in
//
//                    // getting drag a value
//                    let translation = value.translation
//
//                    sliderHeight = -translation.height + lastDragValue
//
//                    // Limiting slider height value
//                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
//
//                    // Negative Height
//                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
//
//                    // Updating progress
//                    let progress = sliderHeight / maxHeight
//
//                    intakeValue = progress <= 1.0 ? progress : 1
//
//                }).onEnded({ (value) in
//
//                    // Limiting slider height value
//                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
//
//                    // Negative Height
//                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
//
//                    // storing last drag value for restoration
//                    lastDragValue = sliderHeight
//
//                }))
//        }
//    }
//}

#Preview {
    AddIntakeCircle(intakeValue: .constant(0.5))
}
