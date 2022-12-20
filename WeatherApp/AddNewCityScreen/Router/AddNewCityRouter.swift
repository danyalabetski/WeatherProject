import UIKit

protocol AddNewCityRouterProtocol {}

final class AddNewCityRouter {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        let view = AddNewCityView()
        let presenter = AddNewCityPresenter(view: view, router: self)
        view.presenter = presenter

        navigationController.pushViewController(view, animated: true)
    }
}

extension AddNewCityRouter: AddNewCityRouterProtocol {}
