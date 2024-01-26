//
//  Pokemon.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import Foundation

struct PokemonListResult: Decodable {
    let count: Int
    let next: String
    let results: [PokemonListEntry]
}

struct PokemonListEntry: Codable {
    let name: String
    let url: String
}

struct PokemonDetail: Codable {
    let name: String
    let sprites: PokemonSprites
    let stats: [PokemonStat]
    // Additional properties to be added as I add more features
}

struct PokemonSprites: Codable {
    let frontDefault: String
    // Additional sprite properties to be added as I add more features
}

struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource
}

struct NamedAPIResource: Codable {
    let name: String
}
