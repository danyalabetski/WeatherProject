import SnapKit
import UIKit

protocol WeatherViewProtocol: AnyObject {
    func updateData()
    func updateDataForRundomJokeLabel(text: String)
    func updateLabels(image: String, temperature: String, condition: String, city: String)
    func changeBackgoundView(image: String)
}

final class WeatherView: UIViewController {

    // MARK: - Properties

    var presenter: WeatherPresenterProtocol?

    // MARK: Private

    private let backgroundImageView = UIImageView()

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.changeImageForBackgroundView()
        presenter?.getWeatherDataFromWeatherService()
        presenter?.getRundomJoke()
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

    // MARK: - Setups

    private func setupBehaviorUIElements() {

        view.addSubviews(view: backgroundImageView, collectionView, backroundView, currentTime, temperatureImageView, currentTemperatureLabel, weatherConditionLabel, cityLabel, titleRundomTextLabel, rundomTextLabel)

        collectionView.delegate = self
        collectionView.dataSource = self

        backroundView.clipsToBounds = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCityDidTappedButton))

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill.viewfinder"), style: .done, target: self, action: #selector(myLocationDidTappedButton))

        navigationController?.navigationBar.tintColor = .systemBlue
    }

    private func setupAppearanceUIElements() {
        collectionView.backgroundColor = UIColor(red: 0.153, green: 0.184, blue: 0.204, alpha: 0.225)
        collectionView.layer.cornerRadius = 25

        backroundView.backgroundColor = UIColor(red: 0.153, green: 0.184, blue: 0.204, alpha: 0.225)
        backroundView.layer.cornerRadius = 35

        currentTime.text = "Today"
        currentTime.customLabel(nameFont: "Poppins-Medium", sizeFont: 25)

        temperatureImageView.contentMode = .scaleAspectFill

        currentTemperatureLabel.customLabel(nameFont: "Poppins-SemiBold", sizeFont: 100)
        weatherConditionLabel.customLabel(nameFont: "Poppins-SemiBold", sizeFont: 20)
        cityLabel.customLabel(nameFont: "Poppins-Medium", sizeFont: 15)
        titleRundomTextLabel.customLabel(nameFont: "Poppins-SemiBold", sizeFont: 20)

        rundomTextLabel.numberOfLines = 0
        rundomTextLabel.textColor = UIColor(named: "CustomColor")
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
            make.left.equalTo(backroundView.snp.left).inset(100)
            make.right.equalTo(backroundView.snp.right).inset(100)
        }

        temperatureImageView.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(86)
            make.left.equalTo(backroundView.snp.left).inset(45)
            make.height.width.equalTo(72)
        }

        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(backroundView.snp.top).inset(48)
            make.right.equalTo(backroundView.snp.right).inset(40)
        }

        weatherConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).inset(15)
            make.left.equalTo(backroundView.snp.left).inset(50)
            make.right.equalTo(backroundView.snp.right).inset(50)
        }

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottom).inset(-10)
            make.left.equalTo(backroundView.snp.left).inset(100)
            make.right.equalTo(backroundView.snp.right).inset(100)
        }

        collectionView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.bottom.equalTo(backroundView.snp.top).inset(425)
            make.left.right.equalToSuperview().inset(34)
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

    @objc private func addNewCityDidTappedButton() {
        presenter?.pushAddNewCityScreen()
    }

    @objc private func myLocationDidTappedButton() {
        presenter?.pushMapScreen()
    }
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
        presenter?.weatherData?.list.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }

        let data = presenter?.weatherData?.list[indexPath.row]

        let weather = presenter?.weatherData?.list[0]
        let icons = weather?.weather[0]

        cell.timeLabel.text = data?.dtTxt.toJustTime()
        cell.temperatureImageView.image = UIImage(named: icons?.icon ?? "")
        cell.temperatureLabel.text = "\(Int(data?.main.temp ?? 0))°"

        return cell
    }
}

// MARK: - WeatherView: WeatherViewProtocol

extension WeatherView: WeatherViewProtocol {
    func updateData() {
        collectionView.reloadData()
    }

    func updateDataForRundomJokeLabel(text: String) {
        rundomTextLabel.text = text
    }

    func updateLabels(image: String, temperature: String, condition: String, city: String) {
        temperatureImageView.image = UIImage(named: image)
        currentTemperatureLabel.text = temperature
        weatherConditionLabel.text = condition
        cityLabel.text = city
    }

    func changeBackgoundView(image: String) {
        backgroundImageView.image = UIImage(named: image)
    }
}
