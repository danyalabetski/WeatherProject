import UIKit

protocol AddNewCityViewProtocol: AnyObject {
    
}

final class AddNewCityView: UIViewController {
    
    // MARK: - Properties
    
    var presenter: AddNewCityPresenterProtocol?
    
    // MARK: Public
    // MARK: Private
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBehaviorUIElements()
        setupAppearanceUIElements()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupConstraints()
    }
    
    // MARK: - API
    
    // MARK: - Setups
    
    private func setupBehaviorUIElements() {
        view.backgroundColor = .brown
    }
    
    private func setupAppearanceUIElements() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    // MARK: - Helpers
    
}

extension AddNewCityView: AddNewCityViewProtocol {
    
}
