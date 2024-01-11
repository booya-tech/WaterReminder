//
//  ListRows.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 12/27/23.
//

import SwiftUI

struct ListRows: View {
    let title: String
    let type: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)

            Spacer()

            Text(type)
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}
#Preview {
    ListRows(title: "Name", type: "Testing")
}
