protocol MapPresenterProtocol {}

final class MapPresenter {

    unowned let view: MapViewProtocol
    private let router: MapRouterProtocol

    init(view: MapView, router: MapRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension MapPresenter: MapPresenterProtocol {}
