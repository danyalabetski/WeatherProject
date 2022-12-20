import UIKit

extension UILabel {
    func customLabel(nameFont: String, sizeFont: CGFloat) {
        textAlignment = .center
        textColor = UIColor(named: "CustomColor")
        font = UIFont(name: nameFont, size: sizeFont)
    }
}
