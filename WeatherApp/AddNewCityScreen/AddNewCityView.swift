import UIKit
import SnapKit

protocol AddNewCityViewProtocol: AnyObject {
    func reloadData()
}

final class AddNewCityView: UIViewController {

    // MARK: - Properties

    var presenter: AddNewCityPresenterProtocol?
        
    // MARK: Public

    // MARK: Private
        
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
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
        setupTableView()
        setupBehaviorUIElements()
        setupAppearanceUIElements()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupConstraints()
    }

    // MARK: - API

    // MARK: - Setups

    private func setupTableView() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupBehaviorUIElements() {
        view.addSubview(tableView)
//        view.addSubviews(view: nameCityLabel, temperatureLabel, descriptionLabel, iconImage)
    }

    private func setupAppearanceUIElements() {
        tableView.backgroundColor = UIColor(named: "ColorCustom")
        
        
    }

    private func setupConstraints() {
        tableView.frame = view.bounds
        
        
    }

    // MARK: - Helpers
}

extension AddNewCityView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell() }

        let weather = presenter?.weatherModel?.list[0].main

        cell.textLabel?.text = "\(Int(weather?.tempMax ?? 0))°"

        return cell
    }
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

    func reloadData() {
        tableView.reloadData()
    }
}

