//
//  NavigationTest.swift
//  PokeBookTests
//
//  Created by Pavel on 8.10.23.
//

import XCTest
@testable import PokeBook

// MARK: - Test PokemonListPresenter navigation

class PokemonListPresenterTests: XCTestCase {
    var presenter: PokemonListPresenter!
    var mockRouter: MockPokemonListRouter!
    
    override func setUpWithError() throws {
        presenter = PokemonListPresenter()
        mockRouter = MockPokemonListRouter()
        presenter.router = mockRouter
    }
    
    override func tearDown() {
        presenter = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testOpenPokemon() {
        let pokemon = Pokemon(name: "testName", pokemonURL: "URL")
        presenter.openPokemon(pokemon: pokemon)
        
        XCTAssertTrue(mockRouter.navigateToSinglePokemonCalled)
        XCTAssertEqual(mockRouter.navigateToSinglePokemonPokemon?.pokemonURL, pokemon.pokemonURL, "Parameters should be equal")
    }
}

class MockPokemonListRouter: PokemonListRouterProtocol {
    var viewController: UIViewController?
    var navigateToSinglePokemonCalled = false
    var navigateToSinglePokemonPokemon: Pokemon?
    
    func navigateToSinglePokemon(pokemon: Pokemon) {
        navigateToSinglePokemonCalled = true
        navigateToSinglePokemonPokemon = pokemon
    }
}

// MARK: - Test PokemonListRouter viewController creation

class PokemonListRouterTests: XCTestCase {
    var router: PokemonListRouter!
    
    override func setUp() {
        super.setUp()
        router = PokemonListRouter()
    }
    
    override func tearDown() {
        router = nil
        super.tearDown()
    }
    
    func testCreateSinglePokemonModule() {
        let pokemon = Pokemon(name: "testName", pokemonURL: "URL")
        let viewController = router.createSinglePokemonModule(pokemon: pokemon) as? SinglePokemonVC
        XCTAssertNotNil(viewController)
        XCTAssertEqual(viewController?.pokemon?.name, pokemon.name, "Parameters should be equal")
    }
    
}
