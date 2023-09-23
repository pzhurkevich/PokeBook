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
    
    func navigateToSinglePokemon()
}

class PokemonListRouter: PokemonListRouterProtocol {
    
    weak var viewController: UIViewController?
    
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
    
    func createSinglePokemonModule() -> UIViewController {
        let view = SinglePokemonViewController()
        
        return view
    }
    
    func navigateToSinglePokemon() {
        let pokemonVC = createSinglePokemonModule()
        viewController?.navigationController?.pushViewController(pokemonVC, animated: true)
    }
    
   
    
}
