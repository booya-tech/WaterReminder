//
//  AiDetectionView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/10/23.
//

import SwiftUI

struct CalculationGoalView: View {
    
    @ObservedObject var hydration: HydrationModel
    
    @Binding var path: NavigationPath
    
    // Top Nav Bar Sheets View
    @State private var backToMainView: Bool = false
    
    // 4 Sheets View
    @State private var genderSheet: Bool = false
    @State private var weightSheet: Bool = false
    @State private var activitySheet: Bool = false
    @State private var weatherSheet: Bool = false
    
    // 4 properties to display views
    @State private var selectedGender: PairCalculationGoal = PairCalculationGoal(id: 1, name: "Male", value: 150)
    @State var selectedWeight = 30
    @State private var selectedActivity: PairCalculationGoal = PairCalculationGoal(id: 1, name: "Low", value: 300)
    @State private var selectedWeather: PairCalculationGoal = PairCalculationGoal(id: 1, name: "Hot", value: 500)
    
    @State var settingsSheet = false
    
    var body: some View {
        
        VStack {
            
            // Topic
            Text("See how much you need").font(Font.custom("NerkoOne-Regular", size: 36)).padding(.vertical, 20)
            
            VStack {
                // Sex
                Button(action: {
                    genderSheet.toggle()
                }, label: {
                    HStack {
                        Text("Sex")
                        
                        Spacer()
                        
                        Text(selectedGender.name)
                        
                    }
                })
                .padding()
                .background(Color("liquid").opacity(0.7))
                .cornerRadius(10)
                .sheet(isPresented: $genderSheet, content: {
                    GenderView(selectedGender: $selectedGender).presentationDetents([.fraction(0.55)])
                    
                })
                
                // Weight
                Button(action: {
                    weightSheet.toggle()
                }, label: {
                    HStack {
                        Text("Weight")
                        
                        Spacer()
                        
                        Text("\(selectedWeight)")
                        
                    }
                })
                .padding()
                .background(Color("liquid").opacity(0.7))
                .cornerRadius(10)
                .sheet(isPresented: $weightSheet, content: {
                    WeightView(selectedWeight: $selectedWeight).presentationDetents([.fraction(0.55)])
                    
                })
                
                // Daily Activity
                Button(action: {
                    activitySheet.toggle()
                }, label: {
                    HStack {
                        Text("Daily Activity")
                        
                        Spacer()
                        
                        Text(selectedActivity.name)
                    }
                })
                .padding()
                .background(Color("liquid").opacity(0.7))
                .cornerRadius(10)
                .sheet(isPresented: $activitySheet, content: {
                    
                    ActivityView(selectedActivity: $selectedActivity).presentationDetents([.fraction(0.55)])
                    
                })
                
                // Weather
                Button(action: {
                    weatherSheet.toggle()
                }, label: {
                    HStack {
                        Text("Weather")
                        
                        Spacer()
                        
                        Text(selectedWeather.name)
                        
                    }
                })
                .padding()
                .background(Color("liquid").opacity(0.7))
                .cornerRadius(10)
                .sheet(isPresented: $weatherSheet, content: {
                    
                    WeatherView(selectedWeather: $selectedWeather).presentationDetents([.fraction(0.55)])
                    
                })
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            // Goal, Calculate Button
            VStack {
                
                // Goal
                VStack {
                    Text("\(hydration.goal) mL").font(Font.custom("NerkoOne-Regular", size: 50))
                    
                    HStack {
                        Text("Your suggested daily goal")
                            .font(Font.custom("NerkoOne-Regular", size: 20))
                        
                        Button(action: {}, label: {
                            Image(systemName: "info.square.fill")
                        })
                        
                    }
                }.padding(.bottom)
                
                // Calculate Button
                VStack {
                    Button(action: {
                        // Add a 2-second delay before calling the calculation method
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            // See at HydrationModel.swift
                            hydration.calculationNewGoal(gender: selectedGender.value, weight: selectedWeight, active: selectedActivity.value, weather: selectedWeather.value)
                        }
                    }, label: {
                        Text("CALCULATE")
                    })
                    .fontWeight(.bold)
                    .buttonStyle(secondaryButtonStyle())
                    
                }
            }
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .background(Color.background)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                }
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                
                Button(action: { settingsSheet.toggle() }, label: {
                    Text("Set Custom")
                }).sheet(isPresented: $settingsSheet, content: {
                    SettingsView(existingIndex: hydration.goalIndex, hydration: hydration)
                })
            }
        }
        .foregroundStyle(Color.white)
    }
}

#Preview {
    CalculationGoalView(hydration: Constants.sampleModel, path: .constant(NavigationPath()))
}
