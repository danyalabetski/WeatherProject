import CoreLocation
import Foundation

final class WeatherService: NSObject {

    private let locationManager = CLLocationManager()

    private var completionHandler: ((MainWeather) -> Void)?

    public func loadWeatherData(_ completionHandler: @escaping ((MainWeather?) -> Void)) {
        locationManager.delegate = self
        self.completionHandler = completionHandler

        locationManager.requestWhenInUseAuthorization()

        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.pausesLocationUpdatesAutomatically = false
                self.locationManager.startUpdatingLocation()
            }
        }
    }

    private func makeDataRequest(latitude: Double, longitude: Double) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&cnt=5&appid=c88dea33fd6e93919619685eb9fdc45c&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        print("URL\(urlString)")

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else { return }

            do {
                let response = try JSONDecoder().decode(MainWeather.self, from: data)
                self.completionHandler?(response)
                print("data: \(response)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }

        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
            print(location.coordinate.latitude, location.coordinate.longitude)
            makeDataRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}
