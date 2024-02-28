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
    private var nextPageURL: URL?
    private var fetchCount = 0
    private let maxFetchCount = 4

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupLanguagePreference()
//        setupRefreshControl()
        print("line20")
        setup()
//        fetchPokemon()
        fetchPokemonListAndDetails(url: URL(string: Constants.API.baseURL))
    }
    
    
    
}

extension PokemonListTableViewController {
    
    // MARK: - App Setup
    private func setup(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func fetchPokemonListAndDetails(url: URL?) {
            guard fetchCount < maxFetchCount, let url = url else { return }

            Webservices().getPokemonList(url: url) { [weak self] result in
                guard let self = self, let result = result else { return }
                DispatchQueue.main.async {
                    if self.pokemonListViewModel == nil {
                        self.pokemonListViewModel = PokemonListViewModel(pokemonListEntry: result.results)
                    } else {
                        self.pokemonListViewModel.pokemonListEntry.append(contentsOf: result.results)
                    }
                    self.nextPageURL = URL(string: result.next ?? "")
                    self.tableView.reloadData()
                    self.fetchCount += 1 // Increment the fetch counter
                }
            }
        }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.pokemonListViewModel == nil ? 0 : self.pokemonListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonListViewModel.numberOfRowsInSection(section)
//        return 3
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as? PokemonListTableViewCell else {
//            fatalError("PokemonListTableViewCell not found")
//        }
//        
//        let newPokemonViewModel = self.pokemonListViewModel.newPokemonAtIndex(indexPath.row)
//        cell.pokeNameTitleLabel.text = newPokemonViewModel.title
//        print("title: \(newPokemonViewModel.title)")
//        print("IMGUR: \(newPokemonViewModel.imageUrl)")
//        if let imageUrl = URL(string: newPokemonViewModel.imageUrl) {
//            cell.imageView?.kf.setImage(with: imageUrl)
//        }
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as? PokemonListTableViewCell else {
            fatalError("PokemonListTableViewCell not found")
        }
        
//        cell.pokeNameTitleLabel.text = "TEST"
        
//        let newPokemonViewModel = self.pokemonListViewModel.newPokemonAtIndex(indexPath.row)
//        cell.pokeNameTitleLabel.text = newPokemonViewModel.title
//        print("title: \(newPokemonViewModel.title)")
//        if let imageURL = newPokemonViewModel.imageURL {
//            cell.newPokemonViewModel.kf.setImage(with: imageURL)
//        }
        
        let pokemonViewModel = self.pokemonListViewModel.newPokemonAtIndex(indexPath.row)
            cell.configure(with: pokemonViewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonDetailViewModel = self.pokemonListViewModel.newPokemonAtIndex(indexPath.row)
        navigateToDetailViewController(with: pokemonDetailViewModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let lastElement = pokemonListViewModel.pokemonListEntry.count - 1
            if indexPath.row == lastElement {
                // Load more data
                if let nextPageURL = nextPageURL {
                    fetchPokemonListAndDetails(url: nextPageURL)
                }
            }
        }
    
    //MARK: - Webservice Call
    
//    private func fetchPokemon() {
//        let pokemonBaseURL = Constants.API.baseURL
//        let url = URL(string: "\(pokemonBaseURL)")!
//        
//        Webservices().getPokemonList(url: url) { pokemonList in
//                DispatchQueue.main.async {
//                    if let pokemonList = pokemonList {
//                        print("pokemonList0 -> \(pokemonList.count)")
//                        self.pokemonListViewModel = PokemonListViewModel(pokemonListEntry: pokemonList)
//                        self.tableView.reloadData()
//                
//                    }
////                    self.refreshControl?.endRefreshing()
//                }
//        }
//        
//        //fetchPokemonDetail
//        
////        Webservices().fetchPokemonList(url: url) { pokemonList in
////            DispatchQueue.main.async {
////                if let pokemonList = pokemonList {
////                    //                        self.newsArticleListViewModel = NewsArticleListViewModel(newsArticle: newsArticles)
////                    //                        self.tableView.reloadData()
////                    print("pokemonList -> \(pokemonList.count)")
////                }
////
//////                    self.refreshControl?.endRefreshing()
////            }
////        }
//    }
    
    
    
    // MARK: - Navigation
    private func navigateToDetailViewController(with pokemonDetailViewModel: PokemonDetailViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "PokemonDetailViewControllerID") as? PokemonDetailViewController {
            detailVC.pokemonDetailViewModel = pokemonDetailViewModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
