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
    
    @State var path = NavigationPath()
    
    // 3 Sheet Views
    // Display addIntake view
    @State var addIntakeSheet = false
    // Display set a goal each day view
    @State var settingsSheet = false
    // Display information view
    @State var infoSheet = false
    
//    @Binding var lastDragValue: CGFloat
    
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Spacer()
                // Top Nav Bar - Setting & Info buttons
                HStack {
                    
                    Button(action: { settingsSheet.toggle() }, label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }).sheet(isPresented: $settingsSheet, content: {
                        SettingsView(existingIndex: hydration.goalIndex, hydration: hydration)
                    })
                    
                    Spacer()
                    
                    Button(action: { infoSheet.toggle() }, label: {
                        Image(systemName: "book.closed.fill")
                            .resizable()
                            .frame(width: 25, height: 30)
                    }).fullScreenCover(isPresented: $infoSheet, content: {
                        InfoView(hydration: hydration, infoSheet: $infoSheet)
                    })
                    
                }.padding(.horizontal, 30)
                
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
                .fullScreenCover(isPresented: $addIntakeSheet, content: {
                    AddIntakeView(hydration: hydration, addIntakeSheet: $addIntakeSheet)
                })
                
                Spacer()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background"))
            
        }
    }
    // The list's built-in deletion
    func delete(at offsets: IndexSet) {
        hydration.removeIntake(offset: offsets)
    }
}

#Preview {
    TodayView(hydration: Constants.sampleModel)
}
