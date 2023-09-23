//
//  SinglePokemonPresenter.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import Foundation

protocol SPViewPresenterProtocol: AnyObject {
    var view: SinglePokemonVCProtocol? { get set }
    func loadData(pokemon: Pokemon)
    
}

protocol SPInteractorProtocol: AnyObject {
    var interactor: SinglePokemonInteractorProtocol? { get set }
    func loadedPokemonInfoFromAPI(pokemonInfo: SinglePokemon)
}

class SinglePokemonPresenter: SPViewPresenterProtocol, SPInteractorProtocol {
    
    var view: SinglePokemonVCProtocol?
    var interactor: SinglePokemonInteractorProtocol?
    
    func loadData(pokemon: Pokemon) {
        self.loadPokemonInfo(pokemon: pokemon)
    }
    
    func loadPokemonInfo(pokemon: Pokemon) {
        interactor?.getPokemonDetail(pokemon: pokemon)
    }
    
    func loadedPokemonInfoFromAPI(pokemonInfo: SinglePokemon) {
        view?.loadPokemonDetail(pokemon: pokemonInfo)
    }
}
