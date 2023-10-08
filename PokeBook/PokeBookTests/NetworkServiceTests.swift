//
//  NetworkServiceTests.swift
//  PokeBookTests
//
//  Created by Pavel on 8.10.23.
//

import XCTest
@testable import PokeBook

class NetworkServiceTests: XCTestCase {
    
    var alamofireManager: AlamofireManagerProtocol!
    
    override func setUp() {
        super.setUp()
        alamofireManager = AlamofireManager()
    }
    
    override func tearDown() {
        alamofireManager = nil
        super.tearDown()
    }
    
    // MARK: - Test getPokemonsList
    
    func testGetPokemonsList() {
        let expectation = XCTestExpectation(description: "Fetch pokemons list")
        
        alamofireManager.getPokemonsList { result in
            switch result {
            case .success(let pokemonsList):
                XCTAssertNotNil(pokemonsList, "Pokemons list should not be nil")
                XCTAssertEqual(pokemonsList.pokemons.count, 10)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch pokemons list: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Test getPokemonDetail
    
    func testGetPokemonDetail() {
        let name = "pikachu"
        let URL = "https://pokeapi.co/api/v2/pokemon/25"
        let expectation = XCTestExpectation(description: "Fetch pokemon detail")
        
        let pokemon = Pokemon(name: name, pokemonURL: URL)
        alamofireManager.getPokemonDetail(pokemon: pokemon) { result in
            switch result {
            case .success(let singlePokemon):
                XCTAssertNotNil(singlePokemon, "SinglePokemon should not be nil")
                expectation.fulfill()
                XCTAssertEqual(singlePokemon.name, name)
            case .failure(let error):
                XCTFail("Failed to fetch pokemon detail: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}

