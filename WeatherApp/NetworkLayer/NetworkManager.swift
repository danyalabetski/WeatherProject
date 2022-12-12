import UIKit

final class NetworkManager {

    static let shared = NetworkManager()
        
    func updateWeatherInfo(latitude: Double, longtitude: Double, completion: @escaping ((Result<MainWeather, Error>) -> Void)) {

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
                    let weatherData = try JSONDecoder().decode(MainWeather.self, from: data)
                    completion(.success(weatherData))
                    print(weatherData)
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func requestForRundomJoke(completion: @escaping ((Result<RundomJokeModel, Error>) -> Void)) {
        guard let url = URL(string: "https://icanhazdadjoke.com/slack") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some Error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let rundomJoke = try JSONDecoder().decode(RundomJokeModel.self, from: data)
                    completion(.success(rundomJoke))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private init() {}
}
