import UIKit

protocol WeatherRouterInput {
    func pushMapView()
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
    func pushMapView() {
        let _ = MapRouter(navigationController: navigationController)
    }
}
