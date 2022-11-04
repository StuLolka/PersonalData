import Foundation

final class PersonalDataModel {
    func createCountryList() -> [String] {
        var countries = [String]()
        let localeCodes = NSLocale.isoCountryCodes

        for localeCode in localeCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: localeCode])
            let locale = NSLocale(localeIdentifier: id)
            guard let country = locale.displayName(forKey: NSLocale.Key.identifier, value: id) else { continue }
            countries.append(country)
        }
        return countries
    }
}
