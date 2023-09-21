//
//  Pokemon.swift
//  PokeBook
//
//  Created by Pavel on 22.09.23.
//

import Foundation

// MARK: Pokemon Entity

struct Pokemon: Codable {
    
    let name: String
    let pokemonURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case pokemonURL = "url"
    }
    
    init(name: String, pokemonURL: String) {
        self.name = name
        self.pokemonURL = pokemonURL
    }
    
}
