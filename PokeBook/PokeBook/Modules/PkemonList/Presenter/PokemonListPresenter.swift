//
//  PokemonListPresenter.swift
//  PokeBook
//
//  Created by Pavel on 22.09.23.
//

import Foundation

// MARK: Protocol for View

protocol ViewPresenterProtocol: AnyObject {
    
    var view: PokemonListVCProtocol? { get set }
    var router: PokemonListRouterProtocol? { get set }
    
    func loadData()
    func openPokemon()
    

}

// MARK: Protocol for Interactor

protocol InteractorPresenterProtocol: AnyObject {
    var interactor: PokemonListInteractorProtocol? { get set }
    func loadedPokemonsFromAPI(pokemons: PokemonsList)
}

final class PokemonListPresenter: ViewPresenterProtocol , InteractorPresenterProtocol {
    
    weak var view: PokemonListVCProtocol?
    var interactor: PokemonListInteractorProtocol?
    var router: PokemonListRouterProtocol?
    
    func loadData() {
        guard let interactor = interactor else { return }
        interactor.getPokemonsList()
    }
    
    
    func loadedPokemonsFromAPI(pokemons: PokemonsList) {
        DispatchQueue.main.async {
            guard let view = self.view else { return }
            view.fillTableWithPokemons(pokemonList: pokemons)
        }
    }
    
    func openPokemon() {
        guard let router = router else { return }
            router.navigateToSinglePokemon()
    }
    
}
