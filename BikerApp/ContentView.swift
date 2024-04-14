//
//  ContentView.swift
//  BaTest
//
//  Created by Safa Şık on 19.11.23.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var locationManager = LocationManager()
    @StateObject private var motionManager = MotionManager()
    @State private var showSaveAlert = false
    @State private var showSavedRides = false
    @State private var showSaveForm = false
    @State private var showCalibrationButton = true
    
    
    func startStopAction() {
        if self.locationManager.isUpdatingLocation {
            self.showSaveAlert = true
            self.locationManager.stopUpdatingLocation()
            self.motionManager.resetCalibration()
            self.motionManager.stopMotionUpdates()
            self.showCalibrationButton = true
        } else {
            self.motionManager.resetMaxAngle()
            self.locationManager.resetDistanceAndTopSpeed()
            self.locationManager.startUpdatingLocation()
            self.motionManager.startMotionUpdates()
            self.showCalibrationButton = false
        }
    }

    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Text("0°")
                        .foregroundStyle(.white)
                        .offset(x:0,y:-193)
                    
                    Text("20°")
                        .foregroundStyle(.white)
                        .offset(x:-64,y:-180)
                    
                    Text("20°")
                        .foregroundStyle(.white)
                        .offset(x:66,y:-180)
                    
                    Text("40°")
                        .foregroundStyle(.white)
                        .offset(x:-125,y:-146)
                    
                    Text("40°")
                        .foregroundStyle(.white)
                        .offset(x:128,y:-146)
                    
                    Text("60°")
                        .foregroundStyle(.white)
                        .offset(x:-168,y:-96)
                    
                    Text("60°")
                        .foregroundStyle(.white)
                        .offset(x:172,y:-96)
                    
                    Image("Motorrad")
                        .rotationEffect(.degrees(motionManager.rotationAngle))
                    
                    Image("Ring-Angle")
                    
                    Image("Tilt Angle")
                    
                    Image("Needle")
                        .rotationEffect(.degrees(motionManager.rotationAngle))
                    
                    Text("\(motionManager.getLeftRight) Max:\n\(abs(motionManager.maxAngle), specifier: "%.0f")°")
                        .multilineTextAlignment(.center)
                        .font(.system(size:24))
                        .foregroundColor(Color.white)
                        .offset(x:0,y: -115)
                    
                    
                    Text("Links:\n\(abs(motionManager.tmpLeftAngle), specifier: "%.0f")°")
                        .multilineTextAlignment(.center)
                        .font(.system(size:24))
                        .foregroundColor(Color.white)
                        .offset(x:-90,y: 75)
                    
                    Text("Rechts:\n\(motionManager.tmpRightAngle, specifier: "%.0f")°")
                        .multilineTextAlignment(.center)
                        .font(.system(size:24))
                        .foregroundColor(Color.white)
                        .offset(x: 85,y: 75)
                }
                .offset(x:0, y:-30)
                ZStack{
                    Image("Speed-Design")
                    
                    Text("\(locationManager.speed * 3.6 ,specifier: "%0.0f")")
                        .font(Font.custom("DS-Digital", size: 140))
                        .foregroundColor(Color.green)
                        .offset(x:-45, y:-35)
                    
                    Text("KM/H")
                        .font(Font.custom("DS-Digital", size: 40))
                        .foregroundColor(Color.green)
                        .offset(x:110, y:0)
                    
                    Text("Top Speed:")
                        .font(Font.custom("DS-Digital", size: 30))
                        .foregroundColor(Color.green)
                        .offset(x: -75,y: 40)
                    
                    Text("\(locationManager.maxSpeed * 3.6, specifier: "%0.0f")")
                        .font(Font.custom("DS-Digital", size: 30))
                        .foregroundColor(Color.green)
                        .offset(x: -118.5,y: 70)
                    
                    Text("KM/H")
                        .font(Font.custom("DS-Digital", size: 30))
                        .foregroundColor(Color.green)
                        .offset(x:-60, y: 70)
                    
                    Text("Range:")
                        .font(Font.custom("DS-Digital", size: 30))
                        .foregroundColor(Color.green)
                        .offset(x:95, y:40)
                    
                    Text("\(locationManager.totalDistance,specifier: "%0.1f") KM")
                        .font(Font.custom("DS-Digital", size: 30))
                        .foregroundColor(Color.green)
                        .offset(x: 96, y: 70)
                    
                    Text("Ø:")
                        .font(Font.custom("DS-Digital", size: 30))
                        .foregroundColor(Color.green)
                        .offset(x: -30, y:-130)
                    
                    Text("\(locationManager.averageSpeed * 3.6,specifier: "%0.0f") KM/H")
                        .font(Font.custom("DS-Digital", size: 30))
                        .foregroundColor(Color.green)
                        .offset(x: 30, y: -130)

                    Button(action: {
                        self.motionManager.resetMaxAngle()
                        self.motionManager.calibrateOrientation()
                    }) {
                        Text("Kalibrieren")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.vertical, 13)
                            .frame(width: 150)
                            .background(showCalibrationButton ? Color.gray : Color.blue)
                            .foregroundColor(showCalibrationButton ? Color.accentColor : Color.white)
                    }
                    .disabled(showCalibrationButton)
                    .cornerRadius(8)
                    .offset(x:90,y:165)
                    
                    Button(action: {
                        startStopAction()
                    }) {
                        Text(self.locationManager.isUpdatingLocation ? "Stop" : "Start")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.vertical, 13)
                            .frame(width: 150)
                            .background(self.locationManager.isUpdatingLocation ? Color.red : Color.green)
                            .foregroundColor(.white)
                    }
                    .cornerRadius(8)
                    .offset(x:-90,y:165)
                }
                .offset(x:0,y:-25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.10, green: 0.10, blue: 0.10), Color(red: 0.14, green: 0.14, blue: 0.14), Color(red: 0.24, green: 0.24, blue: 0.24)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSavedRides.toggle()
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
            }
            .sheet(isPresented: $showSavedRides) {
                RideList()
            }
            .sheet(isPresented: $showSaveForm) {
                let saveRide = Ride(name: "", date: Date(), leftRightAngle: motionManager.getLeftRight, maxAngle: motionManager.maxAngle, topSpeed: locationManager.maxSpeed, distance: locationManager.totalDistance, averageSpeed: locationManager.averageSpeed, isFavorite: false)
                SaveFormUI(ride: saveRide)
            }
            .alert(isPresented: $showSaveAlert) {
                Alert(
                    title: Text("Speichern?"),
                    message: Text("Möchtest du die Daten von der Fahrt speichern?"),
                    primaryButton: .default(Text("Speichern")) {
                        self.showSaveForm = true
                        self.showSaveAlert = false
                    },
                    secondaryButton: .cancel(Text("Abbrechen")) {
                        self.showSaveAlert = false
                    }
                )
            }
            
        }
    }
}

#Preview {
    ContentView()
}
