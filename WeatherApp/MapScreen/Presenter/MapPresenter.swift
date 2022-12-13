protocol MapPresenterProtocol {
    
}

final class MapPresenter {
    
    let view: MapView
    let router: MapRouterProtocol
    
    init(view: MapView, router: MapRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension MapPresenter: MapPresenterProtocol {
    
}
