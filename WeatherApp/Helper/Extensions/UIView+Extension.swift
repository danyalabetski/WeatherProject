import UIKit

extension UIView {
    func addSubviews(view: UIView...) {
        view.forEach { addSubview($0) }
    }
}
