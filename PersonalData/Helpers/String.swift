extension String {
    func doesConsistsOnlyOfLetters() -> Bool {
       for char in self {
          if !(char >= "a" && char <= "z") && !(char >= "A" && char <= "Z")
          && (!(char >= "а" && char <= "я") && !(char >= "А" && char <= "я")) {
             return false
          }
       }
       return true
    }
}
