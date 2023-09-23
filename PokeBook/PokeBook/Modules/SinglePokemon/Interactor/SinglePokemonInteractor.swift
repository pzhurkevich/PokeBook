//
//  SinglePokemonInteractor.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import Foundation
import Alamofire

protocol SinglePokemonInteractorProtocol: AnyObject {
    var presenter: SPInteractorProtocol? { get set }
    
    func getPokemonDetail(pokemon: Pokemon)
}

final class SinglePokemonInteractor: SinglePokemonInteractorProtocol {
    
    weak var presenter: SPInteractorProtocol?
    
    func getPokemonDetail(pokemon: Pokemon) {
        AF.request(pokemon.pokemonURL, method: .get, parameters: nil).responseDecodable(of: SinglePokemon.self) { response in
            switch response.result {
            case .success(let result):
                self.presenter?.loadedPokemonInfoFromAPI(pokemonInfo: result)
      
            case .failure(let error):
                print(error)
            }
        }
    }
}
