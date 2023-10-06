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
    private var database: RealmProtocol = RealmManger()
    private var apiProvider: AlamofireManagerProtocol = AlamofireManager()
    
// MARK: Methods
    
    func getPokemonsList() {
        apiProvider.getPokemonsList { [weak self] result in
            guard let self = self,
                  let presenter = self.presenter else {return}
            switch result {
            case .success(let data):
                data.pokemons.forEach { pokemon in
                self.database.addPokemonListData(data: pokemon)
                }
                presenter.loadedPokemonsFromAPI(pokemons: data)
            case .failure(let error):
                let apiError: SessionError
                if let afError = error as? AFError {
                    switch afError {
                    case .responseSerializationFailed:
                        apiError = SessionError.invalidURL
                    case .sessionTaskFailed:
                        apiError = SessionError.connectionError
                    default:
                        apiError = SessionError.unknownError
                    }
                    presenter.errorLoadPokemonsFromAPI(error: apiError)
                } else {
                    presenter.errorLoadPokemonsFromAPI(error: SessionError.unknownError)
                }
            }
        }
    }
}
