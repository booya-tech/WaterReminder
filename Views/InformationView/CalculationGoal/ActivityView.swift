//
//  DailyActivityView.swift
//  PickerWithSheet
//
//  Created by Panachai Sulsaksakul on 12/7/23.
//

import SwiftUI

struct ActivityView: View {
    
//    @Binding var selectedActivity: String
    
    
    let pairs = [
        PairCalculationGoal(id: 1, name: "Low", value: -300),
        PairCalculationGoal(id: 2, name: "Medium", value: 0),
        PairCalculationGoal(id: 3, name: "Active", value: 400)
    ]
    
    @Binding var selectedActivity: PairCalculationGoal
    
    var body: some View {
        
        ZStack {
            
            Color("background").ignoresSafeArea()
            
            List {
                Picker("", selection: $selectedActivity) {
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

#Preview {
    ActivityView(selectedActivity: .constant(PairCalculationGoal(id: 1, name: "Low", value: 300)))
}
