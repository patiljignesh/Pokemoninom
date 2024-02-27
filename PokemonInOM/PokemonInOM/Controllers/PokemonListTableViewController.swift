//
//  PokemonListTableViewController.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import UIKit
import Kingfisher

class PokemonListTableViewController: UITableViewController {
    
    private var pokemonListViewModel: PokemonListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupLanguagePreference()
//        setupRefreshControl()
        setup()
        fetchPokemon()
    }
    
    
    
}

extension PokemonListTableViewController {
    
    // MARK: - App Setup
    private func setup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
        print("title: \(newPokemonViewModel.title)")
        print("IMGUR: \(newPokemonViewModel.imageUrl)")
        if let imageUrl = URL(string: newPokemonViewModel.imageUrl) {
            cell.imageView?.kf.setImage(with: imageUrl)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonDetailViewModel = self.pokemonListViewModel.newPokemonAtIndex(indexPath.row)
        navigateToDetailViewController(with: pokemonDetailViewModel)
        tableView.deselectRow(at: indexPath, animated: true)
        
//        Webservices().fetchPokemonDetail(url: pokemonDetailViewModel.imageUrl) { [weak self] pokemonDetail in
//                DispatchQueue.main.async {
//                    if let pokemonDetail = pokemonDetail {
//                        self?.navigateToDetailViewController(with: pokemonDetailViewModel)
//                    }
//                }
//            }
//            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Webservice Call
    
    private func fetchPokemon() {
        
        let pokemonBaseURL = Constants.API.baseURL
        let url = URL(string: "\(pokemonBaseURL)")!
        
        Webservices().getPokemonList(url: url) { pokemonList in
                DispatchQueue.main.async {
                    if let pokemonList = pokemonList {
                        print("pokemonList0 -> \(pokemonList.count)")
                        self.pokemonListViewModel = PokemonListViewModel(pokemonListEntry: pokemonList)
                        self.tableView.reloadData()
                
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
    
    
    
    // MARK: - Navigation
    private func navigateToDetailViewController(with pokemonDetailViewModel: PokemonDetailViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "PokemonDetailViewControllerID") as? PokemonDetailViewController {
            detailVC.pokemonDetailViewModel = pokemonDetailViewModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
