//
//  PokemonDetailsViewController.swift
//  PokeApiUikit
//
//  Created by User-G04 on 8/26/22.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    var showPokemon: Pokemon?
    
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var descriptionPokemon: UITextView!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var defensePokemon: UILabel!
    
    @IBOutlet weak var stackLevelPokemon: UIStackView!
    @IBOutlet weak var StackDetailsPokeon: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        typePokemon.text = "Type \(showPokemon?.type.capitalized ?? "")"
        namePokemon.text = "\(showPokemon?.name.uppercased() ?? "")"
        attackPokemon.text = "Attack: \(showPokemon?.attack ?? 0)"
        defensePokemon.text = "Defense: \(showPokemon?.defense ?? 0)"
        descriptionPokemon.text = showPokemon?.description ?? "this pokemon don't has description"
        imagePokemon.loadFrom(URLAddress: showPokemon?.imageUrl ?? "")
        
        descriptionPokemon.layer.cornerRadius = 20
        descriptionPokemon.backgroundColor = UIColor(white: 1, alpha: 0.2)
        
        
    }
    
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else { return }
        
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self.image = loadedImage
                }
            }
        }
    }
}


