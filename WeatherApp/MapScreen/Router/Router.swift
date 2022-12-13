import UIKit

protocol MapRouterProtocol {
    
}

final class MapRouter {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let view = MapView()
        let presenter = MapPresenter(view: view, router: self)
        view.presenter = presenter
        
        navigationController.pushViewController(view, animated: true)
    }
}

extension MapRouter: MapRouterProtocol {
    
}
