//
//  TodayView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI

struct TodayView: View {
    
    // to update when the object's published properties change
    @ObservedObject var hydration: HydrationModel
    
    // Sheet View
    // Display addIntake view
    @State var addIntakeSheet = false
    // Display set a goal each day view
    @State var settingsSheet = false
    // Display information view
    @State var infoSheet = false
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                // Top Nav Bar - Setting & Info buttons
                HStack {
                    
                    Button(action: { settingsSheet.toggle() }, label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }).sheet(isPresented: $settingsSheet, content: {
                        SettingsView(existingIndex: 17, hydration: Constants.sampleModel)
                    })
                    
                    Spacer()
                    
                    Button(action: { infoSheet.toggle() }, label: {
                        Image(systemName: "book.closed.fill")
                            .resizable()
                            .frame(width: 25, height: 30)
                    }).sheet(isPresented: $infoSheet, content: {
                        InfoView()
                    })
                    
                }.padding(.horizontal, 20)
                
                // Date & Description
                VStack {
                    Text(DateHelper.getDateString(day: Date()))
                        .font(Font.custom("NerkoOne-Regular", size: 50))
                        .bold()
                        .padding(.bottom, 5)
                    Text("\(hydration.totalIntake) mL - fluid intake")
                        .font(Font.custom("NerkoOne-Regular", size: 20))
                }
                
                Spacer()
                
                // Water intaked Circle
                ProgressCircle(complete: hydration.progress == 1.0, progress: hydration.progress)
                    .frame(width: 280)
                
                // Description between fluid intaked & goal
                Text("\(hydration.totalIntake) mL - \(hydration.goal) mL")
                    .padding(.top)
                    .font(Font.custom("NerkoOne-Regular", size: 20))
                
                // List of intaked fluid - can delete
                List {
                    ForEach(hydration.intake) { i in
                        DrinkView(drink: i)
                    }
                    .onDelete(perform: delete)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color("background"))
                }
                .scrollContentBackground(.hidden)
                .font(Font.custom("NerkoOne-Regular", size: 20))
                
                // Add Intake button
                Button(action: { addIntakeSheet.toggle() }, label: {
                    Image("addWater-btn")
                })
                .sheet(isPresented: $addIntakeSheet, content: {
                    AddIntakeView(hydration: hydration)
                })
                Spacer()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background"))
            
        }
    }
    // Delete function used by the list's built-int deletion
    func delete(at offsets: IndexSet) {
        hydration.removeIntake(offset: offsets)
    }
}

#Preview {
    TodayView(hydration: Constants.sampleModel)
}
