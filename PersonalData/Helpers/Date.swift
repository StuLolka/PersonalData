import Foundation

extension Date {
    func tooYoungBornDate() -> Date? {
        Calendar.current.date(byAdding: .year, value: -Date.Constants.adult, to: self)
    }

    func tooOldBornDate() -> Date? {
        Calendar.current.date(byAdding: .year, value: -Date.Constants.old, to: self)
    }
}


// MARK: - Constants
extension Date {
    enum Constants {
        static let adult = 18
        static let old = 99
    }
}
