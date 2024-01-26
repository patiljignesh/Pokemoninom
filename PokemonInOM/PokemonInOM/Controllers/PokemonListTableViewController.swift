//
//  PokemonListTableViewController.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import UIKit

class PokemonListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        setupLanguagePreference()
//        setupRefreshControl()
        setup()
//        fetchNewsArticles()
    }
    
    private func setup(){
        fetchPokemon()
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
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.PokemonListViewModel == nil ? 0 : self.PokemonListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.PokemonListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as? NewsArticleListTableViewCell else {
            fatalError("PokemonListTableViewCell not found")
        }
        
        let newsArticleViewModel = self.newsArticleListViewModel.newsArticleAtIndex(indexPath.row)
        cell.newsTitleLabel.text = newsArticleViewModel.title
        cell.newsDescriptionLabel.text = newsArticleViewModel.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetailViewModel = self.newsArticleListViewModel.newsArticleAtIndex(indexPath.row)
        navigateToDetailViewController(with: articleDetailViewModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    private func navigateToDetailViewController(with articleViewModel: ArticleDetailViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ArticleDetailViewControllerID") as? ArticleDetailViewController {
            detailVC.articleViewModel = articleViewModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
