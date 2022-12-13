import UIKit

extension UILabel {
    func customLabel(nameFont: String, sizeFont: CGFloat) {
        self.textAlignment = .center
        self.textColor = UIColor(named: "CustomColor")
        self.font = UIFont(name: nameFont, size: sizeFont)
    }
}
