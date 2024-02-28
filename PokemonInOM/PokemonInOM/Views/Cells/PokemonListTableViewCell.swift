//
//  PokemonListTableViewCell.swift
//  PokemonInOM
//
//  Created by Jigneshkumar Patil on 2024/01/25.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {

    @IBOutlet weak var pokeNameTitleLabel: UILabel!
    @IBOutlet weak var pokeDescriptionLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: PokemonDetailViewModel) {
        pokeNameTitleLabel.text = viewModel.title
                
        // Check if imageUrl is not empty, then load the image
        print("imageURL: \(viewModel.imageURL)")
        let placeholderImage = UIImage(named: "defaultImage") // Adjust as needed
            if let imageURL = viewModel.imageURL {
                self.pokeImageView.kf.setImage(with: imageURL, placeholder: placeholderImage)
            } else {
                self.pokeImageView.image = placeholderImage
            }
    }

}
