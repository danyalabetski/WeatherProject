import UIKit
import MapKit

protocol MapViewProtocol: AnyObject {
    
}

final class MapView: UIViewController {
    
    // MARK: - Properties
    
    var presenter: MapPresenterProtocol!
    
    // MARK: Public
    
    // MARK: Private
    
    private let map = MKMapView()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - Setups
    
    private func setupBehaviorUIElements() {
        
    }
    
    private func setupAppearanceUIElements() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    // MARK: - Helpers
}

extension MapView: MapViewProtocol {
    
}
