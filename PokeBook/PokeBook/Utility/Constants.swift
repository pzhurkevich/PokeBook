//
//  Constants.swift
//  PokeBook
//
//  Created by Pavel on 24.09.23.
//

import Foundation

struct Constants {

    static var baseUrl = "https://pokeapi.co/api/v2/pokemon"
    
    static var limit = 10
    static var offset = 0
    
    static var endpoint: String {
        return baseUrl.appending("/?limit=\(limit)&offset=\(offset)")
    }
    
    }
