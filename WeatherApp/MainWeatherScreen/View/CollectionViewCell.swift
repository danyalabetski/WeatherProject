import UIKit
import SnapKit

final class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    let timeLabel = UILabel()
    let temperatureImageView = UIImageView()
    let temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupBehavior()
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBehavior() {
        contentView.addSubviews(view: timeLabel, temperatureImageView, temperatureLabel)
        contentView.backgroundColor = .clear
        
        timeLabel.textAlignment = .center
        temperatureLabel.textAlignment = .center
        temperatureImageView.contentMode = .scaleAspectFit
    }
    
    private func setupAppearance() {
        
        contentView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.right.equalToSuperview().inset(15)
            make.width.equalTo(27)
        }
        
        temperatureImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(46)
            make.left.right.equalToSuperview().inset(15)
            make.width.height.equalTo(43)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
        
    }
    
}
