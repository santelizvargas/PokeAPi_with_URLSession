//
//  ViewController.swift
//  PokeApiUikit
//
//  Created by User-G04 on 8/26/22.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var searchBarPokemon: UISearchBar!
    @IBOutlet weak var tablePokemon: UITableView!
    
    var pokemonManager = PokemonManager()
    var pokemons: [Pokemon] = []
    var selectedPokemon: Pokemon?
    var filteredPokemon: [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablePokemon.register(UINib(nibName: "PokemonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        pokemonManager.delegate = self
        searchBarPokemon.delegate = self
        tablePokemon.delegate = self
        tablePokemon.dataSource = self
        
        pokemonManager.showPokemon()
        
    }


}
extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemon = []
        
        if searchText == "" {
            filteredPokemon = pokemons
        } else {
            for poke in pokemons {
                           if poke.name.lowercased().contains(searchText.lowercased()) {
                               filteredPokemon.append(poke)
                           }
                       }
        }
        self.tablePokemon.reloadData()
    }
}

extension PokemonViewController: pokemonManagerDelegate {
    func showPokemonData(myList: [Pokemon]) {
        pokemons = myList
        DispatchQueue.main.async {
            self.filteredPokemon = myList
            self.tablePokemon.reloadData()
        }
    }
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablePokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonCellTableViewCell

        cell.namePokemon.text = filteredPokemon[indexPath.row].name.capitalized
        cell.idPokemon.text = "\(filteredPokemon[indexPath.row].id)"
        
        if let urlString = filteredPokemon[indexPath.row].imageUrl as? String{
              if let imageURL = URL(string: urlString) {
                DispatchQueue.global().async {
                  guard let dataImage = try? Data(contentsOf: imageURL) else { return }
                  let image = UIImage(data: dataImage)
                  DispatchQueue.main.async {
                    cell.imagePokemon.image = image
                  }
                }
              }
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = filteredPokemon[indexPath.row]
        
        performSegue(withIdentifier: "showDetailsPokemon", sender: self)
        
//        Deselect
        tablePokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsPokemon" {
            let showPokemonTrue = segue.destination as! PokemonDetailsViewController
            showPokemonTrue.showPokemon = selectedPokemon
        }
    }
    
    
}

