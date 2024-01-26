//
//  PokemonDetailViewModel.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/26.
//

import Foundation
import FirebaseCore

struct PokemonDetailViewModel {
    private let pokemonListEntry: PokemonListEntry
    
}
extension PokemonDetailViewModel {
    init(_ pokemonListEntry: PokemonListEntry){
        self.pokemonListEntry = pokemonListEntry
    }
}

extension PokemonDetailViewModel {
    
    var title: String {
        return self.pokemonListEntry.name
    }
    
    var imageUrl: String {
        return self.pokemonListEntry.url
    }
    
    
//    var description: String {
//        return self.newsArticle.description ?? "No Description available"
//    }
//    
//    var author: String {
//            return newsArticle.author ?? "Unknown Author"
//        }
//        
//    var publishedAt: String {
//        return newsArticle.publishedAt
//    }
}

// MARK: - Save to Firebase
extension PokemonDetailViewModel {
    func addToFavorites(completion: @escaping (Error?) -> Void) {
        FirebaseManager.shared.saveArticle(self) { error in
            completion(error)
        }
    }
}
