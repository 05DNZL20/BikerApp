//
//  Ride.swift
//  BaTest
//
//  Created by Safa Şık on 01.02.24.
//

import Foundation
import SwiftData

@Model
class Ride {
    var name: String
    var date: Date
    var leftRightAngle: String
    var maxAngle: Double
    var topSpeed: Double
    var distance: Double
    var averageSpeed: Double
    var isFavorite: Bool
    
    init(name: String, date: Date, leftRightAngle: String,  maxAngle: Double, topSpeed: Double, distance: Double, averageSpeed: Double, isFavorite: Bool) {
        self.name = name
        self.date = date
        self.leftRightAngle = leftRightAngle
        self.maxAngle = maxAngle
        self.topSpeed = topSpeed
        self.distance = distance
        self.averageSpeed = averageSpeed
        self.isFavorite = isFavorite
    }
}
