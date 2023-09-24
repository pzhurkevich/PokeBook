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
    func openPokemon(pokemon: Pokemon)
    
    func nextPagePokemons()
    func previousPagePokemons()
    

}

// MARK: Protocol for Interactor

protocol InteractorPresenterProtocol: AnyObject {
    var interactor: PokemonListInteractorProtocol? { get set }
    func loadedPokemonsFromAPI(pokemons: PokemonsList)
    func errorLoadPokemonsFromAPI(error: SessionError)
}

final class PokemonListPresenter: ViewPresenterProtocol , InteractorPresenterProtocol {
    
    weak var view: PokemonListVCProtocol?
    var interactor: PokemonListInteractorProtocol?
    var router: PokemonListRouterProtocol?
    
    func loadData() {
        guard let interactor = interactor else { return }
        view?.showSpinner()
        interactor.getPokemonsList()
    }
    
    
    func loadedPokemonsFromAPI(pokemons: PokemonsList) {
        DispatchQueue.main.async {
            guard let view = self.view else { return }
            view.fillTableWithPokemons(pokemonList: pokemons)
        }
        view?.removeSpinner()
    }
    
    func errorLoadPokemonsFromAPI(error: SessionError) {
        view?.errorAlert(error: error)
    }
    
    func openPokemon(pokemon: Pokemon) {
        guard let router = router else { return }
        router.navigateToSinglePokemon(pokemon: pokemon)
    }
    
    func nextPagePokemons() {
        Constants.offset = Constants.offset + 10
        self.loadData()
    }
    
    func previousPagePokemons() {
        if Constants.offset >= 10 {
            Constants.offset = Constants.offset - 10
            self.loadData()
        }
    }
}
