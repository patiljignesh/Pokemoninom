//
//  PokemonDetailViewController.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonDetailViewModel: PokemonDetailViewModel?
    
    // UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let publishedDateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let favoriteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonDetailViewController {
    
    private func setup(){
        view.backgroundColor = .white
        setupScrollView()
        setupContentView()
        setupUIComponents()
        displayArticleDetails()
    }
    
    private func setupScrollView() {
            view.addSubview(scrollView)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        private func setupUIComponents() {
            setupContentView()
            setupTitleLabel()
            setupAuthorLabel()
            setupPublishedDateLabel()
            setupDescriptionLabel()
            setupFavoriteButton()
        }

        private func setupContentView() {
            scrollView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }

        private func setupTitleLabel() {
            contentView.addSubview(titleLabel)
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
            titleLabel.textColor = .darkText
            titleLabel.textAlignment = .left
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        }

        private func setupAuthorLabel() {
            contentView.addSubview(authorLabel)
            authorLabel.numberOfLines = 0
            authorLabel.font = UIFont.boldSystemFont(ofSize: 16)
            authorLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        }

        private func setupPublishedDateLabel() {
            contentView.addSubview(publishedDateLabel)
            publishedDateLabel.numberOfLines = 0
            publishedDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
            publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                publishedDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
                publishedDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                publishedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        }

        private func setupDescriptionLabel() {
            contentView.addSubview(descriptionLabel)
            descriptionLabel.numberOfLines = 0
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: publishedDateLabel.bottomAnchor, constant: 10),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
                // Removed the bottomAnchor constraint for descriptionLabel
            ])
        }

        private func setupFavoriteButton() {
            contentView.addSubview(favoriteButton)
            favoriteButton.setTitle("Add to Favorites", for: .normal)
            favoriteButton.backgroundColor = .blue
            favoriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
            favoriteButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                favoriteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20), // Adjust constant as needed
                favoriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                favoriteButton.widthAnchor.constraint(equalToConstant: 200),
                favoriteButton.heightAnchor.constraint(equalToConstant: 50),
                favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }


        private func displayArticleDetails() {
            if let viewModel = pokemonDetailViewModel {
                titleLabel.text = viewModel.title
                authorLabel.text = "Author: \(viewModel.title)"
                publishedDateLabel.text = "Published: \(viewModel.title)"
                descriptionLabel.text = viewModel.title
            }
        }
    
        @objc private func addToFavorites() {
            pokemonDetailViewModel?.addToFavorites { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.showAlert(title: "Error", message: "Failed to save: \(error.localizedDescription)")
                    } else {
                        self?.showAlert(title: "Success", message: "Article added to favorites.")
                    }
                }
            }
        }
    
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    
}
