//
//  PokemonDetailViewControllerTests.swift
//  PokemonInOMTests
//
//  Created by Jigneshkumar Patil on 2024/02/28.
//

import Foundation
import XCTest
@testable import PokemonInOM

class PokemonDetailViewControllerTests: XCTestCase {

    func test_DisplaysCorrectDetailsForSelectedPokemon() {
        // Given
        let pokemon = Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        let pokemonDetailViewModel = PokemonDetailViewModel(pokemon: pokemon)
        let detailVC = PokemonDetailViewController()
        detailVC.viewModel = pokemonDetailViewModel

        // When
        _ = detailVC.view

        // Then
        XCTAssertEqual(detailVC.nameLabel.text, "Bulbasaur")
        XCTAssertEqual(detailVC.typeLabel.text, "Grass, Poison")
        XCTAssertNotNil(detailVC.imageView.image)
    }

}
