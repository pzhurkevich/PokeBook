//
//  RealmManager.swift
//  PokeBook
//
//  Created by Pavel on 25.09.23.
//

import Foundation
import RealmSwift
import UIKit
import Alamofire

protocol RealmProtocol {
    func addPokemonListData(data: Pokemon)
    func addSinglePokemonDetail(data: SinglePokemon)
}



class RealmManger : RealmProtocol {
    
    var realm = try! Realm()
    private var apiProvider: AlamofireManagerProtocol = AlamofireManager()
    
    
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
            debugPrint("realm error")
        }
    }
    
    func addSinglePokemonDetail(data: SinglePokemon) {
        let savedPokemonsDetails = realm.objects(SinglePokemonDetail.self)
        guard let type = data.types.first else { return }
        apiProvider.saveImageFromWeb(name: data.name, url: data.sprites.frontDefault) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let fileURL):
                let singlePokemonDB = SinglePokemonDetail(name: data.name, height: data.height, weight: data.weight, type: type.typeInfo.name, imageURL: fileURL.absoluteString)
                do {
                    try self.realm.write {
                        if !savedPokemonsDetails.contains(where: { $0.name == data.name}) {
                            self.realm.add(singlePokemonDB)
                        }
                    }
                } catch {
                    debugPrint("realm error")
                }
            case .failure(let error):
                debugPrint("Failed to save image: \(error)")
            }
        }
    }
}
