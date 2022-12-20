import UIKit
import SnapKit

protocol AddNewCityViewProtocol: AnyObject {
   
}

final class AddNewCityView: UIViewController {

    // MARK: - Properties

    var presenter: AddNewCityPresenterProtocol?
        
    // MARK: Public

    // MARK: Private
        
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let nameCityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconImage = UIImageView()
    

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createSearchBar()
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
        view.addSubviews(view: nameCityLabel, temperatureLabel, descriptionLabel, iconImage)
    }

    private func setupAppearanceUIElements() {
        
        
    }

    private func setupConstraints() {
        
        
        
    }

    // MARK: - Helpers
}

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

extension AddNewCityView: AddNewCityViewProtocol {

}

