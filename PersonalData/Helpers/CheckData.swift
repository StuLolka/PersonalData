enum CheckData {
    static func isNameValid(count: Int, str: String, entryView: EntryDataView) -> Bool {
        let canTextBeContinued = count <= GlobalConstants.maxNameLength
        let isOnlyLetters = str.doesConsistsOnlyOfLetters()
        if !canTextBeContinued {
            entryView.showError(error: String.Data.Errors.maxSymbols)
        } else if !isOnlyLetters {
            entryView.showError(error: String.Data.Errors.onlyLetters)
        } else {
            entryView.hideError()
        }
        return canTextBeContinued && isOnlyLetters
    }

    static func isAgeValid(count: Int, str: String, entryView: EntryDataView) -> Bool {
        guard let text = entryView.textField.text else { return false }
        let firstNumber = text.first
        let isItTryToEnterTextAfterZero = firstNumber == "0" && !str.isEmpty
        let canTextBeContinued = count <= GlobalConstants.maxAgeLength && !isItTryToEnterTextAfterZero

        if isItTryToEnterTextAfterZero {
            entryView.showError(error: String.Data.Errors.incorrectAge)
        } else if !canTextBeContinued {
            entryView.showError(error: String.Data.Errors.mustBeLessThan)
        } else {
            entryView.hideError()
        }
        return canTextBeContinued
    }
}
