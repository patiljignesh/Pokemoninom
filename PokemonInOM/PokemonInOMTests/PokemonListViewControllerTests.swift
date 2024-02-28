//
//  PokemonListViewControllerTests.swift
//  PokemonInOMTests
//
//  Created by Jigneshkumar Patil on 2024/02/28.
//

import Foundation
import XCTest
@testable import PokemonInOM

class PokemonListViewControllerTests: XCTestCase {

    var sut: PokemonListViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PokemonListViewController") as! PokemonListViewController
        _ = sut.view
        window.addSubview(sut.view)
        window.makeKeyAndVisible()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        window = nil
    }

    func test_DisplaysPokemonList() {
        // Given
        let pokemonListViewModel = PokemonListViewModel()

        // When
        sut.viewModel = pokemonListViewModel

        // Then
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 151, "There should be 151 rows in the table view")
        XCTAssertEqual(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text, "Bulbasaur", "The first cell should display Bulbasaur")
    }
}
