import SnapKit
import UIKit

protocol AddNewCityViewProtocol: AnyObject {
    func getDataForLabel(temperature: String, city: String, descriptionWeather: String, icon: String)
    func showError(message: String)
    func changeBackgoundView(image: String)
}

final class AddNewCityView: UIViewController {

    // MARK: - Properties

    var presenter: AddNewCityPresenterProtocol?

    // MARK: Public

    // MARK: Private

    private let searchController = UISearchController(searchResultsController: nil)

    private let backgroundImageView = UIImageView()
    private let blurView = UIVisualEffectView()

    private let circleView = UIView()

    private let nameCityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconImage = UIImageView()

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.changeImageForBackgroundView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBehaviorUIElements()
        setupAppearanceUIElements()
        createSearchBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupConstraints()
    }

    // MARK: - Setups

    private func setupBehaviorUIElements() {
        view.addSubviews(view: backgroundImageView, blurView, circleView, iconImage, nameCityLabel, temperatureLabel, descriptionLabel)

        nameCityLabel.customLabel(nameFont: "DolomanPavljenkoLight", sizeFont: 50)
        temperatureLabel.customLabel(nameFont: "DolomanPavljenkoLight", sizeFont: 100)
        descriptionLabel.customLabel(nameFont: "DolomanPavljenkoLight", sizeFont: 30)

        iconImage.contentMode = .scaleAspectFill
    }

    private func setupAppearanceUIElements() {
        title = "Weather City"
        navigationController?.navigationBar.prefersLargeTitles = true

        circleView.backgroundColor = UIColor(red: 0.153, green: 0.184, blue: 0.204, alpha: 0.225)
        circleView.layer.cornerRadius = 20

        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
    }

    private func setupConstraints() {
        backgroundImageView.frame = view.bounds
        blurView.frame = view.bounds

        circleView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(320)
        }

        nameCityLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.top).inset(30)
            make.left.equalTo(circleView.snp.left)
            make.right.equalTo(circleView.snp.right)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.left.equalTo(circleView.snp.left).inset(40)
            make.centerY.equalTo(circleView.snp.centerY)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(circleView.snp.bottom).inset(30)
            make.left.equalTo(circleView.snp.left)
            make.right.equalTo(circleView.snp.right)
        }

        iconImage.snp.makeConstraints { make in
            make.right.equalTo(circleView.snp.right).inset(40)
            make.centerY.equalTo(circleView.snp.centerY)
            make.width.height.equalTo(100)
        }
    }

    // MARK: - Helpers
}

// MARK: - SearchBar

extension AddNewCityView: UISearchBarDelegate {
    private func createSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.leftView?.tintColor = .white
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchButtonClicked(text: searchBar.text ?? "")
    }
}

// MARK: - Alert Controller

extension AddNewCityView {
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "🙁", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.searchController.isActive = false }))
        present(alert, animated: true)
    }
}

extension AddNewCityView: AddNewCityViewProtocol {
    func getDataForLabel(temperature: String, city: String, descriptionWeather: String, icon: String) {
        temperatureLabel.text = temperature
        nameCityLabel.text = city
        descriptionLabel.text = descriptionWeather
        iconImage.image = UIImage(named: icon)
    }

    func showError(message: String) {
        showAlert(message: message)
    }

    func changeBackgoundView(image: String) {
        backgroundImageView.image = UIImage(named: image)
    }
}
