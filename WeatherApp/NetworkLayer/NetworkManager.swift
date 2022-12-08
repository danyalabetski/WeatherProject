import UIKit

final class NetworkManager {

    static let shared = NetworkManager()

    func updateWeatherInfo(latitude: Double, longtitude: Double, completion: @escaping ((Result<WeatherData, Error>) -> Void)) {

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longtitude)&cnt=5&appid=c88dea33fd6e93919619685eb9fdc45c&units=metric") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some Error")
                    completion(.failure(error))
                    return
                }

                guard let data = data else { return }

                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(.success(weatherData))
                    print(weatherData)
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private init() {}
}
