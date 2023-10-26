//
//  PokemonCellTableViewCell.swift
//  PokeApiUikit
//
//  Created by User-G04 on 8/26/22.
//

import UIKit

final class PokemonCellTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private var imagePokemon: UIImageView!
    @IBOutlet private var namePokemon: UILabel!
    @IBOutlet private var idPokemon: UILabel!
    
    // MARK: - Funcitons
    
    func configure(name: String, id: Int) {
        namePokemon.text = name.capitalized
        idPokemon.text = "\(id)"
    }
    
    func setupImage(_ image: UIImage?) {
        imagePokemon.image = image
    }
    
}
