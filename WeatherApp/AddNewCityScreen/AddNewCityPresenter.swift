import Foundation
import Combine

protocol AddNewCityPresenterProtocol {
    var weatherModel: MainSearchWeatherCity? { get }
    func getWeatherForCity()
    func searchButtonClicked(text: String)
    func changeImageForBackgroundView()
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
                case .failure(let error):
                    self.view.showError(message: "The place was not founded")
                    print(error.localizedDescription)
                case .success(let weather):
                    self.weatherModel = weather
                    self.view.getDataForLabel(temperature: "\(Int(weather.list[0].main.temp))",
                                              city: weather.city.name,
                                              descriptionWeather: weather.list[0].weather[0].description,
                                              icon: weather.list[0].weather[0].icon)
                }
            }
        })
    }

    func searchButtonClicked(text: String) {
        network?.city = text
        getWeatherForCity()
    }
    
    func changeImageForBackgroundView() {
        
        let arrayIcons = ["IMG1", "IMG2", "IMG3", "IMG5", "IMG6", "IMG7", "IMG8", "IMG9", "winterImage"]

        view.changeBackgoundView(image: arrayIcons.randomElement() ?? "")
    }
}
