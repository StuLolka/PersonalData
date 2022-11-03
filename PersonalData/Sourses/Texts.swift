import Foundation

extension String {
    enum Data {
        static let title = NSLocalizedString(
            "Data.title",
            bundle: .main,
            value: "Персональные данные",
            comment: "Текст для заголовка экрана"
        )

        static let name = NSLocalizedString(
            "Data.name",
            bundle: .main,
            value: "Имя",
            comment: "Заголовок для ввода текста"
        )

        static let age = NSLocalizedString(
            "Data.age",
            bundle: .main,
            value: "Возраст",
            comment: "Заголовок для ввода текста"
        )

        static let country = NSLocalizedString(
            "Data.country",
            bundle: .main,
            value: "Страна проживания",
            comment: "Заголовок для ввода текста"
        )

        static let chooseSex = NSLocalizedString(
            "Data.chooseSex",
            bundle: .main,
            value: "Пол",
            comment: "Текст над кнопкой выбора пола"
        )

        static let femaleSex = NSLocalizedString(
            "Data.femaleSex",
            bundle: .main,
            value: "Женский",
            comment: "Текст кнопки выбора пола"
        )

        static let maleSex = NSLocalizedString(
            "Data.maleSex",
            bundle: .main,
            value: "Мужской",
            comment: "Текст кнопки выбора пола"
        )

        static let dateBirth = NSLocalizedString(
            "Data.dateBirth",
            bundle: .main,
            value: "Дата рождения",
            comment: "Текст кнопки выбора пола"
        )

        static let children = NSLocalizedString(
            "Data.children",
            bundle: .main,
            value: "Дети (макс. 5)",
            comment: "Текст слева от кнопки 'Добавить ребенка'"
        )

        static let addChild = NSLocalizedString(
            "Data.addChild",
            bundle: .main,
            value: "Добавить ребенка",
            comment: "Текст кнопки для добавления ребенка"
        )

        static let remove = NSLocalizedString(
            "Data.remove",
            bundle: .main,
            value: "Удалить",
            comment: "Текст кнопки для удаления ребенка"
        )

        static let reset = NSLocalizedString(
            "Data.reset",
            bundle: .main,
            value: "Очистить",
            comment: "Текст кнопки для вызова ActionSheet"
        )
        enum Errors {
            static let maxSymbols = NSLocalizedString(
                "Data.Errors.maxSymbols",
                bundle: .main,
                value: "Максимум 50 символов",
                comment: "Текст для ошибки при вводе длинного имени"
            )
            
            static let onlyLetters = NSLocalizedString(
                "Data.Errors.onlyLetters",
                bundle: .main,
                value: "Может содержать только буквы",
                comment: "Текст для ошибки при вводе не букв"
            )

            static let incorrectAge = NSLocalizedString(
                "Data.Errors.incorrectAge",
                bundle: .main,
                value: "Некорректный возраст",
                comment: "Текст для ошибки при вводе чисел после нуля (для ребенка)"
            )

            static let mustBeLessThan = NSLocalizedString(
                "Data.Errors.mustBeLessThan",
                bundle: .main,
                value: "Должно быть меньше 99",
                comment: "Текст для ошибки при попытке ввести трехзначное число"
            )
        }
    }

    enum ActionSheet {
        static let reset = NSLocalizedString(
            "ActionSheet.reset",
            bundle: .main,
            value: "Сбросить данные",
            comment: "Текст кнопки ActionSheet"
        )
        static let cancel = NSLocalizedString(
            "ActionSheet.cancel",
            bundle: .main,
            value: "Отмена",
            comment: "Текст кнопки ActionSheet"
        )
    }
}
