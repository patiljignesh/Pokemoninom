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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
