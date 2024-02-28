//
//  PokemonListViewModel.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import Foundation

struct PokemonListViewModel {
    var pokemonListEntry: [PokemonListEntry]
}

extension PokemonListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.pokemonListEntry.count
    }
    
    func newPokemonAtIndex(_ index: Int) -> PokemonDetailViewModel {
        let pokemonListEntry = self.pokemonListEntry[index]
        return PokemonDetailViewModel(pokemonListEntry)
    }
}

