//
//  PokemonListRouter.swift
//  PokeBook
//
//  Created by Pavel on 22.09.23.
//

import Foundation
import UIKit

protocol PokemonListRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func navigateToSinglePokemon(pokemon: Pokemon)
}

class PokemonListRouter: PokemonListRouterProtocol {
    
    weak var viewController: UIViewController?
    
// MARK: Methods
    
    static func createPokemonListModule() -> UIViewController {
        let view = PokemonListVC()
        let interactor = PokemonListInteractor()
        let router = PokemonListRouter()
        let presenter = PokemonListPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    func createSinglePokemonModule(pokemon: Pokemon) -> UIViewController {
        let view = SinglePokemonVC()
        let interactor = SinglePokemonInteractor()
        let presenter = SinglePokemonPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.pokemon = pokemon
        return view
    }
    
    func navigateToSinglePokemon(pokemon: Pokemon) {
        let pokemonVC = createSinglePokemonModule(pokemon: pokemon)
        viewController?.navigationController?.pushViewController(pokemonVC, animated: true)
    }
}
