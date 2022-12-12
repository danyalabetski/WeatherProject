import CoreLocation

final class LocationManager: NSObject {
    
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    var weatherData: MainWeather?

    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.pausesLocationUpdatesAutomatically = false
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    private override init() {}
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)

            NetworkManager.shared.updateWeatherInfo(latitude: lastLocation.coordinate.latitude,
                                                    longtitude: lastLocation.coordinate.longitude) { [weak self] data in

                switch data {
                case .failure(let error): print(error)
                case .success(let data):
                    self?.weatherData = data
                }
            }
        }
    }
}
