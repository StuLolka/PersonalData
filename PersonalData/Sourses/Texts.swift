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
            comment: "Текст для placeholder"
        )

        static let age = NSLocalizedString(
            "Data.age",
            bundle: .main,
            value: "Возраст",
            comment: "Текст для placeholder"
        )

        static let children = NSLocalizedString(
            "Data.children",
            bundle: .main,
            value: "Дети (макс. 5)",
            comment: "Текст слева от кнопки 'Добавить ребенка'"
        )

        static let addKid = NSLocalizedString(
            "Data.addKid",
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
