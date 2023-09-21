//
//  PokemonsList.swift
//  PokeBook
//
//  Created by Pavel on 22.09.23.
//

import Foundation

// MARK: Pokemons List Entity

struct PokemonsList: Codable {
    
    let pokemons: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case pokemons = "results"
    }
    
    init(pokemons: [Pokemon]) {
        self.pokemons = pokemons
    }
}
