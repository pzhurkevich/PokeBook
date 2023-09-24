//
//  PokemonListData.swift
//  PokeBook
//
//  Created by Pavel on 25.09.23.
//

import Foundation
import RealmSwift

class PokemonListData: Object {
   @Persisted var name: String
   @Persisted var pokemonURL: String

   convenience init(name: String, pokemonURL: String) {
       self.init()
       self.name = name
       self.pokemonURL = pokemonURL
   }
}

