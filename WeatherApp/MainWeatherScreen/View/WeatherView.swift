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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.getDataForWeatherData()
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

        view.addSubviews(view: backgroundImageView, collectionView, backroundView, currentTime, temperatureImageView, currentTemperatureLabel)

        collectionView.delegate = self
        collectionView.dataSource = self
        
        backroundView.clipsToBounds = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCountryDidTappedButton))

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill.viewfinder"), style: .done, target: self, action: #selector(myLocationDidTappedButton))

        navigationController?.navigationBar.tintColor = .cyan
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
    }
 
    private func setupConstraints() {
        backgroundImageView.frame = view.bounds

        backroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.left.right.equalToSuperview().inset(34)
            make.bottom.equalToSuperview().inset(470)
        }

        currentTime.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(25)
            make.left.equalTo(backroundView.snp.left).inset(120)
            make.right.equalTo(backroundView.snp.right).inset(120)
        }

        temperatureImageView.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(106)
            make.left.equalTo(backroundView.snp.left).inset(66)
            make.height.width.equalTo(72)
        }

        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(68)
            make.right.equalTo(backroundView.snp.right).inset(65)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.bottom).inset(-35)
            make.bottom.equalToSuperview().inset(259)
            make.left.equalToSuperview().inset(34)
            make.right.equalToSuperview().inset(34)
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
        
        let data = presenter?.weatherData?.list[indexPath.row]

        cell.timeLabel.text = data?.main.temp.description
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

//import SwiftUI
//
//struct CompositionalPrivider: PreviewProvider {
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
//}
