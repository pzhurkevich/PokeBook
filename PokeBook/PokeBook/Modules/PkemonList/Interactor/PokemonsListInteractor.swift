//
//  PokemonsListInteractor.swift
//  PokeBook
//
//  Created by Pavel on 22.09.23.
//

import Foundation
import Alamofire

protocol PokemonListInteractorProtocol: AnyObject {
    var presenter: InteractorPresenterProtocol? { get set }
    
    func getPokemonsList()
}

final class PokemonListInteractor: PokemonListInteractorProtocol {
    
    let baseUrl = "https://pokeapi.co/api/v2/pokemon"
    let limit = 10
    var offset = 0
    
    weak var presenter: InteractorPresenterProtocol?
  
    func getPokemonsList() {

        let endpoint = "\(baseUrl)/?limit=\(limit)&offset=\(offset)"
        AF.request(endpoint, method: .get, parameters: nil).responseDecodable(of: PokemonsList.self) { response in
            switch response.result {
            case .success(let result):
                
               // print(result)
                
                guard let presenter = self.presenter else { return }
                presenter.loadedPokemonsFromAPI(pokemons: result)
                
            case .failure(let error):
                print(error)
            }
        }
    
    }
}
