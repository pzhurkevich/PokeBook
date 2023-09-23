//
//  SinglePokemon.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import Foundation

// MARK: Pokemon Detail Entity
struct SinglePokemon: Codable {
    
    let name: String
    let height: Int
    let weight: Int
    let types: [Type]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case types = "types"
        case height, weight
    }
}


// MARK: Type Entity
struct Type: Codable {
    
    let typeInfo: Info
    
    enum CodingKeys: String, CodingKey {
        case typeInfo = "type"
    }
    
}

// MARK: Info Entity

struct Info: Codable {
    
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
