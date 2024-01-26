//
//  PokemonListViewModel.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import Foundation

struct PokemonListViewModel {
    let pokemonListEntry: [PokemonListEntry]
}

extension PokemonListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.pokemonListEntry.count
    }
    
    func newsArticleAtIndex(_ index: Int) -> PokemonListViewModel {
        let pokemonListEntry = self.pokemonListEntry[index]
        return PokemonListViewModel(pokemonListEntry)
    }
}

struct PokemonListViewModel {
    private let pokemonListEntry: PokemonListEntry
    
}

