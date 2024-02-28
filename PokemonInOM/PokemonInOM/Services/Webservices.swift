//
//  Webservices.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import Foundation

class Webservices {
    
    func getPokemonList(url: URL?, completion: @escaping (PokemonListResult?) -> ()) {
            let url = url ?? URL(string: Constants.API.baseURL)!
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completion(nil)
                    return
                }
                let pokemonListResult = try? JSONDecoder().decode(PokemonListResult.self, from: data)
                completion(pokemonListResult)
            }.resume()
        }
    

    func fetchPokemonDetail(for pokemon: PokemonListEntry, completion: @escaping (String?) -> Void) {
            guard let url = URL(string: pokemon.url) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                if let detail = try? JSONDecoder().decode(PokemonDetail.self, from: data) {
                    completion(detail.sprites.frontDefault)
                } else {
                    completion(nil)
                }
            }.resume()
        }
}

