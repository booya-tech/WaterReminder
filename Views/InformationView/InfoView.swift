//
//  InfoView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI

struct Topic: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var imageName: String
    var color: Color
}

struct InfoView: View {
    
    @ObservedObject var hydration: HydrationModel
    
    @Binding var infoSheet: Bool
    
    @State var path = NavigationPath()
    
    let sectionOne: [Topic] = [
        .init(name: "Calculation Goal", imageName: "drop.circle.fill", color: .blue)
    ]
    
    let sectionTwo: [Topic] = [
        .init(name: "Statistic", imageName: "heart.square.fill", color: .white),
        .init(name: "Reminder", imageName: "calendar.badge.clock", color: .white)
    ]
    
    
    
    var body: some View {
        NavigationStack(path: $path) {
            
            ZStack {
                Color("background").ignoresSafeArea()
                
                
                List {
                    Section("Section 1") {
                        ForEach(sectionOne, id: \.name) { topic in
                            NavigationLink(value: topic) {
                                VStack(alignment: .leading) {
                                    Text("\(hydration.goal)mL").font(.largeTitle).fontWeight(.bold)
                                    Text("your suggested daily goal \nChange gender, weight, daily activity, or weather")
                                }
                            }
                        }
                    }.listRowBackground(Color("liquid").opacity(0.7))
                    
                    Section("Section 2") {
                        ForEach(sectionTwo, id: \.name) { topic in
                            NavigationLink(value: topic) {
                                Label(topic.name, systemImage: topic.imageName)
                                    .foregroundColor(topic.color)
                            }
                        }
                    }.listRowBackground(Color("liquid").opacity(0.7))
                }
                .foregroundStyle(Color.white)
                .navigationDestination(for: Topic.self) { topic in
                    switch topic {
                    case sectionOne[0]:
                        CalculationGoalView(hydration: hydration, path: $path)
                    case sectionTwo[0]:
                        Text("Statistic View")
                    case sectionTwo[1]:
                        Text("Reminder View")
                    default:
                        CalculationGoalView(hydration: hydration, path: $path)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            infoSheet.toggle()
                        } label: {
                            Image(systemName: "arrowshape.backward.fill")
                                .foregroundStyle(Color.white)
                        }
                    }
                }
            }
        }.scrollContentBackground(.hidden)
        
    }
}

#Preview {
    InfoView(hydration: Constants.sampleModel, infoSheet: .constant(true))
}
