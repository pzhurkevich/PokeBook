//
//  LocalizationAdapter.swift
//  PokeBook
//
//  Created by Pavel on 5.10.23.
//

import Foundation

enum LocalizationAdapter: String {
    case pokemonType = "pokemon_type"
    case pokemonHeight = "pokemon_height"
    case pokemonWeight = "pokemon_weight"
    case details = "detais"
    case prevButton  = "prevButton"
    case nextButton  = "nextButton"
    case connectionError = "connectionError"
    case invalidURL  = "invalidURL"
    case unknownError  = "unknownError"
    case errorTitle = "errorTitle"
    case retryButton = "retryButton"
    case cm = "cm"
    case kg = "kg"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    static func getTextFor(string: LocalizationAdapter) -> String {
        return string.localizedString()
    }
}
