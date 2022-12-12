import Foundation

protocol WeatherPresenterProtocol {
    var weatherData: MainWeather? { get }
//    func getWeatherData()
    func getWeatherDataFromWeatherService()
    func getRundomJoke()
}

final class WeatherPresenter {

//    var locationManager: LocationManager?

    var weatherData: MainWeather?
        
    var weatherService: WeatherService?
            
    unowned let view: WeatherViewProtocol
    private let router: WeatherRouterInput

    init(view: WeatherViewProtocol, router: WeatherRouterInput) {
        self.view = view
        self.router = router
    }
}

extension WeatherPresenter: WeatherPresenterProtocol {
    
    func getWeatherDataFromWeatherService() {
        weatherService?.loadWeatherData({ weather in
            DispatchQueue.main.async {
                self.weatherData = weather
                self.view.updateData()
            }
        })
    }

//    func getWeatherData() {
//        NetworkManager.shared.updateWeatherInfo(latitude: 37.32514788, longtitude: -122.02506739) { weather in
//            switch weather {
//            case .failure(let error): print(error.localizedDescription)
//            case .success(let weather):
//                self.weatherData = weather
//                self.view.updateData()
//            }
//        }
//    }
    
    func getRundomJoke() {
        NetworkManager.shared.requestForRundomJoke { [weak self] joke in
            switch joke {
            case .failure(let error): print(error.localizedDescription)
            case .success(let joke):
                joke.attachments.forEach { oneJoke in
                    self?.view.updateDataForRundomJokeLabel(text: oneJoke.text)
                }
            }
        }
    }
}
