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
    
    weak var presenter: InteractorPresenterProtocol?
    var database: RealmProtocol = RealmManger()
    
// MARK: Methods
    
    func getPokemonsList() {

        AF.request(Constants.endpoint, method: .get, parameters: nil).responseDecodable(of: PokemonsList.self) { [weak self] response in
            guard let self = self,
                  let presenter = self.presenter else { return }
            switch response.result {
            case .success(let result):
                
                // print(result)
                result.pokemons.forEach { pokemon in
                    self.database.addPokemonListData(data: pokemon)
                }
                presenter.loadedPokemonsFromAPI(pokemons: result)
                
            case .failure(let error):

                switch error {
                    
                case .responseSerializationFailed:
                    let apiError = SessionError.invalidURL
                    presenter.errorLoadPokemonsFromAPI(error: apiError)
                case .sessionTaskFailed:
                    let apiError = SessionError.connectionError
                    presenter.errorLoadPokemonsFromAPI(error: apiError)
                default:
                    let apiError = SessionError.unknownError
                    presenter.errorLoadPokemonsFromAPI(error: apiError)
                }
            }
        }
        
    }
}
