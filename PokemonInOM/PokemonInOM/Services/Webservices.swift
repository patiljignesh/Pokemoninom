//
//  Webservices.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import Foundation

class Webservices {
    
    func getPokemonList(url: URL, completion: @escaping ([PokemonListEntry]?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let pokemonListResult = try? JSONDecoder().decode(PokemonListResult.self, from: data)
                
                if let pokemonListResult = pokemonListResult {
                    completion(pokemonListResult.results)
                    print("pokemonList_result_name_0: \(pokemonListResult.results[0].name)")
                }
            }
            
        }.resume()
    }
    

    func fetchPokemonDetail(url: String, completion: @escaping (PokemonDetail?) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let pokemonDetail = try? JSONDecoder().decode(PokemonDetail.self, from: data)
            completion(pokemonDetail)
        }.resume()
    }
}


//    func fetchPokemonList(url: URL, completion: @escaping ([PokemonListEntry]?) -> ()) {
//            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data, error == nil else {
//                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                let pokemonList = try? JSONDecoder().decode([PokemonListEntry].self, from: data)
//                completion(pokemonList ?? [])
//            }.resume()
//        }
//
