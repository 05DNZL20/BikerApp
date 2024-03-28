//
//  RideRow.swift
//  BaTest
//
//  Created by Safa Şık on 01.02.24.
//

import SwiftUI

struct RideRow: View {
    var ride: Ride
    
    var body: some View {
        HStack {
            Text(ride.name)
            Text(ride.date.formatted())
            Spacer()
            if(ride.isFavorite){
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
        }
    }
}

#Preview {
    RideRow(ride: Ride(name: "test", date: Date.now, leftRightAngle: "R", maxAngle: 45.0, topSpeed: 11.2, distance: 22.3, averageSpeed: 33.4, isFavorite: false))
}
