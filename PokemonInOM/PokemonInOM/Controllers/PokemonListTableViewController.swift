//
//  PokemonListTableViewController.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import UIKit

class PokemonListTableViewController: UITableViewController {
    
    private var pokemonListViewModel: PokemonListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupLanguagePreference()
//        setupRefreshControl()
        setup()
//        fetchNewsArticles()
    }
    
    private func fetchPokemon() {
        
        let pokemonBaseURL = Constants.API.baseURL
        let url = URL(string: "\(pokemonBaseURL)")!
        
        Webservices().getPokemonList(url: url) { pokemonList in
                DispatchQueue.main.async {
                    if let pokemonList = pokemonList {
                        print("pokemonList0 -> \(pokemonList.count)")
//                        self.newsArticleListViewModel = NewsArticleListViewModel(newsArticle: newsArticles)
//                        self.tableView.reloadData()
                        
                        if let firstPokemonURL = pokemonList.first?.url {
                            Webservices().fetchPokemonDetail(url: firstPokemonURL) { pokemonDetail in
                                if let pokemonDetail = pokemonDetail {
                                    // Handle the detailed data (e.g., update the UI or a model)
                                    print("Fetched details for: \(pokemonDetail.name)")
                                }
                            }
                        }
                        
                    }
//                    self.refreshControl?.endRefreshing()
                }
        }
        
        //fetchPokemonDetail
        
        
        
//        Webservices().fetchPokemonList(url: url) { pokemonList in
//            DispatchQueue.main.async {
//                if let pokemonList = pokemonList {
//                    //                        self.newsArticleListViewModel = NewsArticleListViewModel(newsArticle: newsArticles)
//                    //                        self.tableView.reloadData()
//                    print("pokemonList -> \(pokemonList.count)")
//                }
//                
////                    self.refreshControl?.endRefreshing()
//            }
//        }
    }
    
}

extension PokemonListTableViewController {
    
    // MARK: - App Setup
    private func setup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        fetchPokemon()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.pokemonListViewModel == nil ? 0 : self.pokemonListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as? PokemonListTableViewCell else {
            fatalError("PokemonListTableViewCell not found")
        }
        
        let newPokemonViewModel = self.pokemonListViewModel.newPokemonAtIndex(indexPath.row)
        cell.pokeNameTitleLabel.text = newPokemonViewModel.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonDetailViewModel = self.pokemonListViewModel.newPokemonAtIndex(indexPath.row)
        navigateToDetailViewController(with: pokemonDetailViewModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    private func navigateToDetailViewController(with pokemonDetailViewModel: PokemonDetailViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ArticleDetailViewControllerID") as? PokemonDetailViewController {
            detailVC.pokemonDetailViewModel = pokemonDetailViewModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
