//
//  WeatherView.swift
//  PickerWithSheet
//
//  Created by Panachai Sulsaksakul on 12/7/23.
//

import SwiftUI



struct WeatherView: View {
    
    //    var weatherExample = Weather.weatherExamples()
    
    let pairs = [
        PairCalculationGoal(id: 1, name: "Hot", value: 500),
        PairCalculationGoal(id: 2, name: "Warm", value: 250),
        PairCalculationGoal(id: 3, name: "Temperate", value: 0),
        PairCalculationGoal(id: 4, name: "Cold", value: -250)
    ]
    
    @Binding var selectedWeather: PairCalculationGoal
    
    var body: some View {
        
        VStack {
            
            ZStack {
                Color("background").ignoresSafeArea()
                
                List {
                    Picker("", selection: $selectedWeather) {
                        ForEach(pairs) { pair in
                            HStack {
                                Text(pair.name)
                                
                                Spacer()
                                
                                if(pair.value < 0) {
                                    Text("\(pair.value)").foregroundStyle(.secondary)
                                } else {
                                    Text("+\(pair.value)").foregroundStyle(.secondary)
                                }
                            }
                            .tag(pair)
                        }
                        
                    }
                    .padding()
                    .pickerStyle(.inline)
                }
            }
            .scrollContentBackground(.hidden)
            
        }
        
    }
}

#Preview {
    WeatherView(selectedWeather: .constant(PairCalculationGoal(id: 1, name: "Hot", value: 500)))
}
