//
//  RideList.swift
//  BaTest
//
//  Created by Safa Şık on 01.02.24.
//

import SwiftUI
import SwiftData

struct RideList: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Ride.date) var rides: [Ride] = []
    @State private var showFavoritesOnly = false
    
    func updateFavoriteStatus(ride: Ride, isFavorite: Bool) {
        if let index = rides.firstIndex(where: { $0 == ride }) {
            rides[index].isFavorite = isFavorite
            
        }
    }

    var filteredRides: [Ride] {
        rides.filter {ride in
            (!showFavoritesOnly || ride.isFavorite)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites")
                }
                
                ForEach(filteredRides) { ride in
                    NavigationLink {
                        RideDetail(ride: ride, updateFavoriteStatus: updateFavoriteStatus)
                    } label: {
                        RideRow(ride: ride)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(rides[index])
                    }
                }
            }
            .navigationTitle ("Saved Rides")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                    }
                }
            }
        } detail: {
            Text("Select a Ride")
        }
    }
}

#Preview {
    RideList()
}
