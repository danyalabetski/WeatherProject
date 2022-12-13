import Foundation

extension String {
    func toJutTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: Date())
    }
}
