import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private var locationManager: CLLocationManager?
    @Published var speed: Double = 0.0
    @Published var averageSpeed: Double = 0.0
    @Published var log: String = ""
    @Published var maxSpeed: Double = 0.0
    @Published var totalDistance: Double = 0.0
    @Published var isUpdatingLocation: Bool = false

    
    private var lastLocation: CLLocation?
    private var startTime: Date?

    init(locationManager: CLLocationManager = CLLocationManager()) {
        super.init()
        self.locationManager = locationManager
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
    }
}
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



extension LocationManager: CLLocationManagerDelegate {

    
    func startUpdatingLocation() {
            locationManager?.startUpdatingLocation()
            log = "Location updates stopped"
            startTime = Date()
            resetDistanceAndTopSpeed()
            isUpdatingLocation = true
        }

    func stopUpdatingLocation() {
            locationManager?.stopUpdatingLocation()
            log = "Location updates stopped"
            isUpdatingLocation = false
        }

    
    func resetDistanceAndTopSpeed() {
        self.maxSpeed = 0
        self.totalDistance = 0
        self.averageSpeed = 0
        self.startTime = Date()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }

        if let lastLocation = lastLocation {
            let distance = lastLocation.distance(from: currentLocation)
            totalDistance += distance / 1000.0

            speed = currentLocation.speed

            if speed < 0 {
                speed = 0
            }

            if speed > maxSpeed {
                maxSpeed = speed
            }

            if let startTime = startTime {
                let elapsedTime = Date().timeIntervalSince(startTime)
                let totalDistanceRounded = totalDistance.rounded(toPlaces: 1) * 1000
                let elapsedTimeRounded = elapsedTime.rounded(toPlaces: 1)

                averageSpeed = totalDistanceRounded / elapsedTimeRounded
            }
        }

        lastLocation = currentLocation
    }
}
