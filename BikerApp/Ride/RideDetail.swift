//
//  RideDetail.swift
//  BaTest
//
//  Created by Safa Şık on 01.02.24.
//

import SwiftUI

struct RideDetail: View {
    @State private var isFavorite: Bool
    @Bindable var ride: Ride
    var updateFavoriteStatus: (Ride, Bool) -> Void
    
    init(ride: Ride, updateFavoriteStatus: @escaping (Ride, Bool) -> Void) {
        _isFavorite = State(initialValue: ride.isFavorite)
        self.ride = ride
        self.updateFavoriteStatus = updateFavoriteStatus
    }
    
    var body: some View {
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
                //.frame(width: 360.71, height: 360)
                    .rotationEffect(.degrees(ride.maxAngle))
                
                Image("Ring-Angle")
                //.frame(width: 220, height: 220)
                
                Image("Tilt Angle")
                //.frame(width: 220, height: 220)
                
                Image("Needle")
                //.frame(width: 220, height: 220)
                    .rotationEffect(.degrees(ride.maxAngle))
                
                Text("\(ride.leftRightAngle) Max:\n\(abs(ride.maxAngle), specifier: "%.0f")°")
                    .multilineTextAlignment(.center)
                    .font(.system(size:24))
                    .foregroundColor(Color.white)
                    .offset(x:0,y: -115)
            }
            .offset(x:0, y:-30)
            ZStack{
                Image("Speed-Design")
                
                Text("\(ride.topSpeed * 3.6 ,specifier: "%0.0f")")
                    .font(Font.custom("DS-Digital", size: 140))
                    .foregroundColor(Color.green)
                    .offset(x:-45, y:-35)
                
                Text("KM/H")
                    .font(Font.custom("DS-Digital", size: 40))
                    .foregroundColor(Color.green)
                    .offset(x:110, y:0)
                
                Text("Average Speed:")
                    .font(Font.custom("DS-Digital", size: 30))
                    .foregroundColor(Color.green)
                    .offset(x: -65,y: 40)
                
                Text("\(ride.averageSpeed * 3.6, specifier: "%0.0f")")
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
                
                Text("\(ride.distance,specifier: "%0.1f") KM")
                    .font(Font.custom("DS-Digital", size: 30))
                    .foregroundColor(Color.green)
                    .offset(x: 96, y: 70)
            }
            .offset(x:0, y:-30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.10, green: 0.10, blue: 0.10), Color(red: 0.14, green: 0.14, blue: 0.14), Color(red: 0.24, green: 0.24, blue: 0.24)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteButton(isSet: $isFavorite) {
                    updateFavoriteStatus(ride, isFavorite)
                }
            }
        }
    }
}

/*#Preview {
    RideDetail(ride: Ride(name: "test", date: Date.now, leftRightAngle: "R", maxAngle: 45, topSpeed: 11.2, distance: 22.3, averageSpeed: 33.4, isFavorite: false)
}*/
