//
//  WeightView.swift
//  PickerWithSheet
//
//  Created by Panachai Sulsaksakul on 12/7/23.
//

import SwiftUI

struct WeightView: View {
    
    @Binding var selectedWeight: Int
    
    var body: some View {
        
        Picker("", selection: $selectedWeight) {
            ForEach(Constants.weights, id: \.self) { weight in
                Text("\(weight)")
            }
        }
        .pickerStyle(.wheel)
    
    }
}

#Preview {
    WeightView(selectedWeight: .constant(0))
}
