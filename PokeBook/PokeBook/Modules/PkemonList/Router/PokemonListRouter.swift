//
//  PokemonListRouter.swift
//  PokeBook
//
//  Created by Pavel on 22.09.23.
//

import Foundation
import UIKit


class PokemonListRouter {
    
    
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
        
        return view
    }
    
}
