import Foundation

extension String {
    func toJustTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: Date())
    }
}
