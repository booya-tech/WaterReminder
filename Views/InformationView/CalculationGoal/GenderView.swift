//
//  GenderView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 12/7/23.
//

import SwiftUI

struct GenderView: View {
    
    let genders = [
        PairCalculationGoal(id: 1, name: "Male", value: 150),
        PairCalculationGoal(id: 2, name: "Female", value: 0),
        PairCalculationGoal(id: 3, name: "Pregnant", value: 300),
        PairCalculationGoal(id: 4, name: "Breastfeed", value: 700)
    ]
    
    @Binding var selectedGender: PairCalculationGoal
    
    var body: some View {
        
        ZStack {
            
            Color("background").ignoresSafeArea()
            
            List {
                Picker("", selection: $selectedGender) {
                    ForEach(genders) { gender in
                        HStack {
                            Text(gender.name)
                            Spacer()
                            Text("+\(gender.value)").foregroundStyle(.secondary)
                        }
                        .tag(gender)
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
    GenderView(selectedGender: .constant(PairCalculationGoal(id: 1, name: "Male", value: 150)))
}
