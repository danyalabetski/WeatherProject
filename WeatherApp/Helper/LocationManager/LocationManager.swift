import CoreLocation
import Combine

final class LocationManager: NSObject {
        
    private let locationManager = CLLocationManager()
        
    var inputSubjectForWeather = PassthroughSubject<WeatherData, Never>()
    
    var weatherData: WeatherData?
    
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
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
            
            NetworkManager.shared.updateWeatherInfo(latitude: lastLocation.coordinate.latitude,
                                                    longtitude: lastLocation.coordinate.longitude) { [weak self] data in
                
                guard let self = self else { return }
                switch data {
                case .failure(let error): print(error)
                case .success(let data):
                    self.inputSubjectForWeather.send(data)
                }
            }
        }
    }
}
