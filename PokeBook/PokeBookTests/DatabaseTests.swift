//
//  DatabaseTests.swift
//  PokeBookTests
//
//  Created by Pavel on 8.10.23.
//
import XCTest
import RealmSwift
@testable import PokeBook

class RealmManagerTests: XCTestCase {


    // MARK: - Test addPokemonListData
    
    func testAddPokemonListData() {
        let testData = Pokemon(name: "testPokemon", pokemonURL: "testURL")
        RealmManager.shared.addPokemonListData(data: testData)
        let savedPokemons = RealmManager.shared.fetchAllSavedPokemons()
        XCTAssertFalse(savedPokemons.isEmpty, "Database with test data cannot be empty")
        XCTAssertTrue(savedPokemons.contains(where: {$0.name == testData.name}))
        XCTAssertTrue(savedPokemons.contains(where: {$0.pokemonURL == testData.pokemonURL}))
        XCTAssertEqual(savedPokemons.filter({$0.pokemonURL == testData.pokemonURL}).count, 1, "test data should only be in one instance")
    }
}
