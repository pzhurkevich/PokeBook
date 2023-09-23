//
//  SinglePokemonPresenter.swift
//  PokeBook
//
//  Created by Pavel on 23.09.23.
//

import Foundation

protocol SPViewPresenterProtocol: AnyObject {
    var view: SinglePokemonVCProtocol? { get set }
    func loadData()
    
}

protocol SPInteractorProtocol: AnyObject {
   
}

class SinglePokemonPresenter: SPViewPresenterProtocol {
    
    var view: SinglePokemonVCProtocol?
    func loadData() {
        
    }
}
