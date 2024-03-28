//
//  SaveFormUI.swift
//  BaTest
//
//  Created by Safa Şık on 02.02.24.
//

import SwiftUI
import SwiftData

struct SaveFormUI: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    var ride: Ride
    
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Titel", text: $name)
            }
            .navigationTitle("Save Ride")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let saveRide = Ride(name: name, date: Date(), leftRightAngle: ride.leftRightAngle, maxAngle: ride.maxAngle, topSpeed: ride.topSpeed, distance: ride.distance, averageSpeed: ride.averageSpeed, isFavorite: false)
                        context.insert(saveRide)
                        dismiss()
                    }
                }
            }
        }
    }
}

/*#Preview {
    var ride = Ride(name: "Test", date: Date(), maxAngle: "L 13", topSpeed: 11.2, distance: 22.1, averageSpeed: 5.1, isFavorite: false)
    SaveFormUI(ride: ride)
}*/
