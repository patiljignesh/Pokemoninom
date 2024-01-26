//
//  FirebaseManager.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/26.
//

import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    private let deviceID = getDeviceID()

    func saveArticle(_ article: PokemonDetailViewModel, completion: @escaping (Error?) -> Void) {
//        let articleData: [String: Any] = [
//            "title": article.title,
//            "author": article.title,
//            "publishedAt": article.title,
//            "description": article.title,
//            "deviceID": deviceID
//        ]
//
//        db.collection("favorites").addDocument(data: articleData) { error in
//            completion(error)
//        }
    }

    func fetchFavoriteArticles(completion: @escaping ([PokemonDetailViewModel]?, Error?) -> Void) {
//        db.collection("favorites").whereField("deviceID", isEqualTo: deviceID).getDocuments { (snapshot, error) in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                var articles = [PokemonDetailViewModel]()
//                for document in snapshot?.documents ?? [] {
//                    let data = document.data()
//                    if let title = data["title"] as? String
//                    {
//                        // Create a NewsArticle object
////                        let pokemonDetailViewModel = PokemonDetailViewModel(PokemonListEntry.init(from: title as! Decoder))
//                        // Create an ArticleDetailViewModel with the NewsArticle
////                        let pokemonViewModel = PokemonDetailViewModel(pokemonDetailViewModel)
////                        articles.append(articleViewModel)
//                    }
//                }
//                completion(articles, nil)
//            }
//        }
    }
}

