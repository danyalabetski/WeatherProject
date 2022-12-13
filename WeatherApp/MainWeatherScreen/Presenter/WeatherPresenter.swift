import Foundation

protocol WeatherPresenterProtocol {
    var weatherData: MainWeather? { get }
    func getWeatherDataFromWeatherService()
    func getRundomJoke()
    func changeImageForBackgroundView()
}

final class WeatherPresenter {

    var weatherData: MainWeather?
    var weatherService: WeatherService?
    var networkManagerProtocol: NetworkManagerProtocol?

    unowned let view: WeatherViewProtocol
    private let router: WeatherRouterInput

    init(view: WeatherViewProtocol, router: WeatherRouterInput) {
        self.view = view
        self.router = router
        self.weatherService = WeatherService()
        self.networkManagerProtocol = NetworkManager()
    }

    func changeImageForBackgroundView() {
        
        let arrayIcons = ["IMG1", "IMG2", "IMG3", "IMG4", "IMG5", "IMG6", "IMG7", "IMG8", "IMG9", "winterImage"]
        
        self.view.changeBackgoundView(image: arrayIcons.randomElement() ?? "")
    }
}

extension WeatherPresenter: WeatherPresenterProtocol {

    func getWeatherDataFromWeatherService() {
        weatherService?.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.weatherData = weather
                self.view.updateLabels(image: weather?.list[0].weather[0].icon ?? "",
                                       temperature: "\(Int(weather?.list[0].main.temp ?? 0))°",
                                       condition: weather?.list[0].weather[0].weatherDescription ?? "",
                                       city: weather?.city.name ?? "")
                
                self.view.updateData()
            }
        }
    }

    func getRundomJoke() {
        networkManagerProtocol?.requestForRundomJoke(completion: { [weak self] joke in
            switch joke {
            case .failure(let error): print(error.localizedDescription)
            case .success(let joke):
                joke.attachments.forEach { oneJoke in
                    self?.view.updateDataForRundomJokeLabel(text: oneJoke.text)
                }
            }
        })
    }
}
