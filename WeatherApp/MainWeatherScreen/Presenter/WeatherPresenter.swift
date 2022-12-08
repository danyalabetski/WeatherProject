import Combine

protocol WeatherPresenterProtocol {
    var weatherData: WeatherData? { get }
    func getDataForWeatherData()
}

final class WeatherPresenter {
    
    private var cancellables: Set<AnyCancellable> = []
            
    var locationManager: LocationManager?
    
    var weatherData: WeatherData?
    
    unowned let view: WeatherViewProtocol
    private let router: WeatherRouterInput
    
    init(view: WeatherViewProtocol, router: WeatherRouterInput) {
        self.view = view
        self.router = router
    }
}

extension WeatherPresenter: WeatherPresenterProtocol {
   
    func getDataForWeatherData() {
        locationManager?.inputSubjectForWeather.sink { [weak self] data in
            self?.weatherData = data
            self?.view.updateData()
        }
        .store(in: &cancellables)
    }
    
}

