//
//  IntermediateWorkoutView.swift
//  HyroxFitnessApp
//
//  Created by Michael Bergsten on 2023-02-08.
//

import SwiftUI

struct IntermediateWorkoutView: View {

    @State var mapOn = false
    @State var start = false
    @State var count = 0

    var locationManager = LocationManager()
    var db = ViewModel()
    
    @ObservedObject var timeManager = TimerManager()
    
    
    var body: some View {
        
        if mapOn {
            MapView()
        }
        
        ZStack {
            Color.black
            .ignoresSafeArea()
            
            VStack {
                
                intermediateWorkout()
                intermediateText()
                
                Text(String(format: "%02d:%02d:%02d", Int(timeManager.elapsedTime / 3600), Int(timeManager.elapsedTime.truncatingRemainder(dividingBy: 3600) / 60), Int(timeManager.elapsedTime.truncatingRemainder(dividingBy: 60))))
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color .white)
                
                Button(action: {
                    self.start.toggle()
                    mapOn.toggle()
                    locationManager.startLocationUpdates()
                    timeManager.start()
                    
                }){
                    Text("START INTERMEDIATE WORKOUT")
                        .foregroundColor(Color .white)
                        .font(.headline)
                }
                
                Button(action: {
                    self.start.toggle()
                    mapOn.toggle()
                    locationManager.stopLocationUpdates()
                    timeManager.stop()
                    let newUser = User(fitnessLevel: "Novice", date: Date(), elapsedTime: timeManager.elapsedTime)
                    db.addData(user: newUser)

                    
                    
                }){
                    Text("STOP INTERMEDIATE WORKOUT")
                        .foregroundColor(Color .red)
                        .font(.headline)
                }
            }
        }
    }
}

struct IntermediateWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        IntermediateWorkoutView()
    }
}

struct intermediateWorkout: View {
    var body: some View {
        Text("8 Rounds of: 1 Km Run, 20 Walking Lunges")
            .padding(.top, -200)
            .foregroundColor(.green)
            .fontWeight(.bold)
            .font(.largeTitle)
    }
}

struct intermediateText: View {
    var body: some View {
        Text("Finish in 25 minutes or under to move to Advanced.")
            .padding(.top, -100)
            .foregroundColor(.red)
            .padding(.horizontal)
            .fontWeight(.bold)
    }
}
