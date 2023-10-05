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
   
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    static func getTextFor(string: LocalizationAdapter) -> String {
        return string.localizedString()
    }
}
