//
//  PokemonData.swift
//  PokeBook
//
//  Created by Pavel on 25.09.23.
//

import Foundation
import RealmSwift

class SinglePokemonDetail: Object {
  
    @Persisted var name: String
    @Persisted var height: Int
    @Persisted var weight: Int
    @Persisted var type: String
    @Persisted var image: Data

    convenience init(name: String, height: Int, weight: Int, type: String, image: Data) {
        self.init()
        self.name = name
        self.height = height
        self.weight = weight
        self.type = type
        self.image = image
    }
}
