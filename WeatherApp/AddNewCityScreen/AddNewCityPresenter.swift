import Foundation

protocol AddNewCityPresenterProtocol {
    var weatherModel: MainSearchWeatherCity? { get }
    func getWeatherForCity()
    func searchButtonClicked(text: String)
}

final class AddNewCityPresenter {
    
    private var network: WeatherServiceForSearchCityProtocol?
    var weatherModel: MainSearchWeatherCity?

    unowned let view: AddNewCityViewProtocol
    private let router: AddNewCityRouterProtocol

    init(view: AddNewCityViewProtocol, router: AddNewCityRouterProtocol) {
        self.view = view
        self.router = router
        self.network = WeatherServiceForSearchCity()
    }
}

extension AddNewCityPresenter: AddNewCityPresenterProtocol {
    func getWeatherForCity() {
        network?.requestForWeatherInCity(completion: { data in
            DispatchQueue.main.async {
                switch data {
                case .failure(let error): print(error.localizedDescription)
                case .success(let weather):
                    self.weatherModel = weather
                }
            }
        })
    }
    
    func searchButtonClicked(text: String) {
        self.network?.city = text
        getWeatherForCity()
    }
}
