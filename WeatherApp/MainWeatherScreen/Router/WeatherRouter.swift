import UIKit

protocol WeatherRouterInput {
    func pushMapScreen()
    func pushAddNewCityScreen()
}

final class WeatherRouter {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        let view = WeatherView()
        let presenter = WeatherPresenter(view: view, router: self)
        view.presenter = presenter
        navigationController.pushViewController(view, animated: true)
    }
}

extension WeatherRouter: WeatherRouterInput {
    func pushMapScreen() {
        let _ = MapRouter(navigationController: navigationController)
    }
    
    func pushAddNewCityScreen() {
        let _ = AddNewCityRouter(navigationController: navigationController)
    }
}
