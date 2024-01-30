//
//  InfoView.swift
//  WaterReminder
//
//  Created by Panachai Sulsaksakul on 11/9/23.
//

import SwiftUI
import UserNotifications

struct Topic: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var imageName: String
    var color: Color
}

struct InfoView: View {
    
    @ObservedObject var hydration: HydrationModel
    //    var notificationManager: NotificationManager
    var notificationManager = NotificationManager()
    
    @Binding var infoSheet: Bool
    
    @State var path = NavigationPath()
    
    @State private var intakeReminder = false
    
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
                
                VStack() {
                    // Toggle for reminder user, if on send notification to user every hour.
                    Toggle("Reminder", isOn: $intakeReminder)
                        .font(Font.custom("NerkoOne-Regular", size: 28))
                        .listRowBackground(Color.clear)
                    // To make the equation from each section by horizontal
                        .padding(.horizontal)
                        .foregroundStyle(Color.white)
                        .onChange(of: intakeReminder) { newValue in
                            if newValue {
                                notificationManager.scheduleNotification()
                            } else {
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            }
                        }
                    
                    List {
                        //                        // Toggle for reminder user, if on send notification to user every hour.
                        //                        Toggle("Reminder", isOn: $intakeReminder)
                        //                            .font(Font.custom("NerkoOne-Regular", size: 36))
                        //                            .listRowBackground(Color.clear)
                        //                        // To make the equation from each section by horizontal
                        ////                            .padding(.horizontal, -18)
                        //                            .foregroundStyle(Color.white)
                        //                            .onChange(of: intakeReminder) { newValue in
                        //                                if newValue {
                        //                                    notificationManager.scheduleNotification()
                        //                                } else {
                        //                                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        //                                }
                        //                            }
                        
                        Section("") {
                            ForEach(sectionOne, id: \.name) { topic in
                                NavigationLink(value: topic) {
                                    VStack(alignment: .leading) {
                                        Text("\(hydration.goal)mL").font(.largeTitle).fontWeight(.bold)
                                        Text("your suggested daily goal \nChange gender, weight, daily activity, or weather")
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color("liquid").opacity(0.7))
                        
                        // Wait for update in the future
//                        Section("Section 2") {
//                            ForEach(sectionTwo, id: \.name) { topic in
//                                NavigationLink(value: topic) {
//                                    Label(topic.name, systemImage: topic.imageName)
//                                        .foregroundColor(topic.color)
//                                }
//                            }
//                        }.listRowBackground(Color("liquid").opacity(0.7))
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
                }
                .onAppear {
                    // Retrieve the saved value when the view appears
                    intakeReminder = UserDefaults.standard.bool(forKey: "intakeReminder")
                }
                .onDisappear {
                    // Save the value when the view disappears
                    UserDefaults.standard.set(intakeReminder, forKey: "intakeReminder")
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
        }.scrollContentBackground(.hidden)
        
    }
}

#Preview {
    InfoView(hydration: Constants.sampleModel, infoSheet: .constant(true))
}
