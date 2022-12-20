import CoreLocation
import MapKit
import UIKit

protocol MapViewProtocol: AnyObject {}

final class MapView: UIViewController {

    // MARK: - Properties

    var presenter: MapPresenterProtocol?

    // MARK: Private

    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBehaviorUIElements()
        setupAppearanceUIElements()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupLocationManager()
    }

    // MARK: - Setups

    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func setupBehaviorUIElements() {
        view.addSubviews(view: mapView)
    }

    private func setupAppearanceUIElements() {}

    private func setupConstraints() {
        mapView.frame = view.bounds
    }
}

extension MapView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()

            render(location)
        }
    }

    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)

        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

        let region = MKCoordinateRegion(center: coordinate, span: span)

        mapView.setRegion(region, animated: true)

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}

extension MapView: MapViewProtocol {}
