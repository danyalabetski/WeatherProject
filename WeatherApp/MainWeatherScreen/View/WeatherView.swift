import SnapKit
import UIKit

protocol WeatherViewProtocol: AnyObject {
    func updateData()
}

final class WeatherView: UIViewController {

    // MARK: - Properties

    var presenter: WeatherPresenterProtocol?

    // MARK: Public

    // MARK: Private

    private let backgroundImageView = UIImageView()

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    private let backroundView = UIView()

    private let currentTime = UILabel()
    private let temperatureImageView = UIImageView()
    private let currentTemperatureLabel = UILabel()
    private let weatherConditionLabel = UILabel()
    private let cityLabel = UILabel()
    
    private let titleRundomTextLabel = UILabel()
    private let rundomTextLabel = UILabel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

//        LocationManager.shared.startLocationManager()
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

        view.addSubviews(view: backgroundImageView, collectionView, backroundView, currentTime, temperatureImageView, currentTemperatureLabel, weatherConditionLabel, cityLabel, titleRundomTextLabel, rundomTextLabel)

        collectionView.delegate = self
        collectionView.dataSource = self

        backroundView.clipsToBounds = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCountryDidTappedButton))

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill.viewfinder"), style: .done, target: self, action: #selector(myLocationDidTappedButton))

        navigationController?.navigationBar.tintColor = .systemBlue
    }

    private func setupAppearanceUIElements() {
        backgroundImageView.image = UIImage(named: "winterImage")

        collectionView.backgroundColor = UIColor(red: 0.153, green: 0.184, blue: 0.204, alpha: 0.225)
        collectionView.layer.cornerRadius = 25

        backroundView.backgroundColor = UIColor(red: 0.153, green: 0.184, blue: 0.204, alpha: 0.225)
        backroundView.layer.cornerRadius = 35

        currentTime.text = "Now"
        currentTime.textAlignment = .center
        currentTime.font = UIFont(name: "Poppins-Medium", size: 25)

        temperatureImageView.image = UIImage(systemName: "sun.min.fill")
        temperatureImageView.contentMode = .scaleAspectFit

        currentTemperatureLabel.text = "32"
        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.font = UIFont(name: "Poppins-SemiBold", size: 100)
        
        weatherConditionLabel.text = "Sunny"
        weatherConditionLabel.textAlignment = .center
        weatherConditionLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        
        cityLabel.text = "New York"
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        
        
        titleRundomTextLabel.text = "Rundom Text"
        titleRundomTextLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        
        rundomTextLabel.text = "Improve him believe opinion offered met and end cheered forbade. Friendly as stronger speedily by recurred. Son interest wandered sir addition end say. Manners beloved affixed picture men ask."
        rundomTextLabel.numberOfLines = 0
        rundomTextLabel.font = UIFont(name: "Poppins-SemiBold", size: 15)
        
    }

    private func setupConstraints() {
        backgroundImageView.frame = view.bounds

        backroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.left.right.equalToSuperview().inset(34)
            make.height.equalTo(240)
        }

        currentTime.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(20)
            make.left.equalTo(backroundView.snp.left).inset(120)
            make.right.equalTo(backroundView.snp.right).inset(120)
        }

        temperatureImageView.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(86)
            make.left.equalTo(backroundView.snp.left).inset(60)
            make.height.width.equalTo(72)
        }

        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(48)
            make.right.equalTo(backroundView.snp.right).inset(60)
        }
        
        weatherConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).inset(15)
            make.left.equalTo(backroundView.snp.left).inset(120)
            make.right.equalTo(backroundView.snp.right).inset(120)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottom).inset(-10)
            make.left.equalTo(backroundView.snp.left).inset(100)
            make.right.equalTo(backroundView.snp.right).inset(100)
        }

        collectionView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.bottom.equalTo(backroundView.snp.top).inset(425)
            make.left.equalToSuperview().inset(34)
            make.right.equalToSuperview().inset(34)
        }
        
        titleRundomTextLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(34)
        }
        
        rundomTextLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(34)
            make.top.equalTo(titleRundomTextLabel.snp.top).inset(30)
        }
    }

    // MARK: - Helpers

    @objc private func addNewCountryDidTappedButton() {}

    @objc private func myLocationDidTappedButton() {}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension WeatherView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 4.5, height: collectionView.frame.width / 2.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }

//        let data = presenter?.weatherData?.list[indexPath.row]

        cell.timeLabel.text = "Now"
        cell.temperatureImageView.image = UIImage(systemName: "sun.min.fill")
        cell.temperatureLabel.text = "21"

        return cell
    }
}

// MARK: - WeatherView: WeatherViewProtocol

extension WeatherView: WeatherViewProtocol {
    func updateData() {
        collectionView.reloadData()
    }
}

// import SwiftUI
//
// struct CompositionalPrivider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        let tabBar = WeatherView()
//        func makeUIViewController(context: UIViewControllerRepresentableContext<CompositionalPrivider.ContainerView>) -> WeatherView {
//            tabBar
//        }
//
//        func updateUIViewController(_ uiViewController: CompositionalPrivider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CompositionalPrivider.ContainerView>) {}
//    }
// }
