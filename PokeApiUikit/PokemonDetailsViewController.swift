//
//  PokemonDetailsViewController.swift
//  PokeApiUikit
//
//  Created by User-G04 on 8/26/22.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var typePokemon: UILabel!
    @IBOutlet private var namePokemon: UILabel!
    @IBOutlet private var imagePokemon: UIImageView!
    @IBOutlet private var descriptionPokemon: UITextView!
    @IBOutlet private var attackPokemon: UILabel!
    @IBOutlet private var defensePokemon: UILabel!
    @IBOutlet private var stackLevelPokemon: UIStackView!
    @IBOutlet private var StackDetailsPokeon: UIStackView!
    
    var showPokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        imagePokemon.loadFrom(URLAddress: showPokemon?.imageUrl ?? "")
    }
    
    private func setupView() {
        typePokemon.text = "Type \(showPokemon?.type.capitalized ?? "")"
        namePokemon.text = "\(showPokemon?.name.uppercased() ?? "")"
        attackPokemon.text = "Attack: \(showPokemon?.attack ?? 0)"
        defensePokemon.text = "Defense: \(showPokemon?.defense ?? 0)"
        descriptionPokemon.text = showPokemon?.description ?? "this pokemon don't has description"
        
        descriptionPokemon.layer.cornerRadius = 20
        descriptionPokemon.backgroundColor = UIColor(white: 1, alpha: 0.2)
    }
    
}

extension UIImageView {
    
    func loadFrom(URLAddress: String) {
        
        guard let url = URL(string: URLAddress) else { return }
        
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: url),
               let loadedImage = UIImage(data: imageData) {
                self.image = loadedImage
            }
        }
    }
}


