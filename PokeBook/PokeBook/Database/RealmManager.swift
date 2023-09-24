//
//  RealmManager.swift
//  PokeBook
//
//  Created by Pavel on 25.09.23.
//

import Foundation
import RealmSwift

protocol RealmProtocol {
    func addPokemonListData(data: Pokemon)
    func addSinglePokemonDetail(data: SinglePokemon) 
}



class RealmManger : RealmProtocol {
    var realm = try! Realm()
    
    func addPokemonListData(data: Pokemon) {
        
        let savedPokemons = realm.objects(PokemonListData.self)
        
        let listPokemonsDB = PokemonListData(name: data.name, pokemonURL: data.pokemonURL)
        do {
            try realm.write {
                if !savedPokemons.contains(where: { pokemon in
                    pokemon.name == data.name}) {
                    realm.add(listPokemonsDB)
                }
            }
        } catch {
            print("realm error")
        }
        
    }
    
    func addSinglePokemonDetail(data: SinglePokemon) {
        
    }
}
