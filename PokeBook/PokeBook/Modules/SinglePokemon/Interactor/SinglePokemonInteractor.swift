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
    private var apiProvider: AlamofireManagerProtocol = AlamofireManager()
    
// MARK: Methods
    
    func getPokemonDetail(pokemon: Pokemon) {
        apiProvider.getPokemonDetail(pokemon: pokemon) { [weak self] result in
            guard let self = self,
                  let presenter = self.presenter else {return}
            switch result {
            case .success(let result):
                RealmManager.shared.addSinglePokemonDetail(data: result)
                presenter.loadedPokemonInfoFromAPI(pokemonInfo: result)
            case .failure(let error):
              errorOutput(error: error)
            }
        }
    }
    
    private func errorOutput(error: Error){
        let apiError: SessionError
        guard let presenter = presenter else {return}
        if let afError = error as? AFError {
            switch afError {
            case .responseSerializationFailed:
                apiError = SessionError.invalidURL
            case .sessionTaskFailed:
                apiError = SessionError.connectionError
            default:
                apiError = SessionError.unknownError
            }
            presenter.errorLoadDetailFromAPI(error: apiError)
        } else {
            presenter.errorLoadDetailFromAPI(error: SessionError.unknownError)
        }
    }
}
