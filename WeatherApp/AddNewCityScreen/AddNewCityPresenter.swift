protocol AddNewCityPresenterProtocol {
    
}

final class AddNewCityPresenter {
    
    unowned let view: AddNewCityViewProtocol
    private let router: AddNewCityRouterProtocol
    
    
    init(view: AddNewCityViewProtocol, router: AddNewCityRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension AddNewCityPresenter: AddNewCityPresenterProtocol {
    
}
