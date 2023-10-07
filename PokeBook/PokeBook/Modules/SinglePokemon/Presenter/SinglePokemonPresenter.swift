//
//  SinglePokemonPresenter.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import Foundation

// MARK: Protocol for View

protocol SPViewPresenterProtocol: AnyObject {
    var view: SinglePokemonVCProtocol? { get set }
    func loadData(pokemon: Pokemon)
    
}

// MARK: Protocol for Interactor

protocol SPInteractorProtocol: AnyObject {
    var interactor: SinglePokemonInteractorProtocol? { get set }
    func loadedPokemonInfoFromAPI(pokemonInfo: SinglePokemon)
    func errorLoadDetailFromAPI(error: SessionError)
}

class SinglePokemonPresenter: SPViewPresenterProtocol, SPInteractorProtocol {
    
    var view: SinglePokemonVCProtocol?
    var interactor: SinglePokemonInteractorProtocol?
    
// MARK: Methods
    
    func loadData(pokemon: Pokemon) {
        guard let view = view else {return}
        view.showSpinner()
        self.loadPokemonInfo(pokemon: pokemon)
    }
    
    func loadPokemonInfo(pokemon: Pokemon) {
        guard let interactor = self.interactor else {return}
        interactor.getPokemonDetail(pokemon: pokemon)
    }
    
    func loadedPokemonInfoFromAPI(pokemonInfo: SinglePokemon) {
        guard let view = view else {return}
        view.loadPokemonDetail(pokemon: pokemonInfo)
        view.removeSpinner()
    }
    
    func errorLoadDetailFromAPI(error: SessionError) {
        guard let view = view else {return}
        view.errorAlert(error: error)
    }
}
