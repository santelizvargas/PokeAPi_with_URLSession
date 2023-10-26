//
//  ViewController.swift
//  PokeApiUikit
//
//  Created by User-G04 on 8/26/22.
//

import UIKit

final class PokemonViewController: UIViewController {

    @IBOutlet private var searchBarPokemon: UISearchBar!
    @IBOutlet private var tablePokemon: UITableView!
    
    private var pokemonManager = PokemonManager()
    private var pokemons: [Pokemon] = []
    private var selectedPokemon: Pokemon?
    private var filteredPokemon: [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupTableView() {
        tablePokemon.delegate = self
        tablePokemon.dataSource = self
        
        tablePokemon.register(UINib(nibName: "PokemonCellTableViewCell", bundle: nil), 
                              forCellReuseIdentifier: "cell")
    }
    
    private func setupView() {
        searchBarPokemon.delegate = self
        pokemonManager.delegate = self
        setupTableView()
        pokemonManager.showPokemon()
    }


}

// MARK: - UISearchBar Delegate

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemon = []
        
        if searchText.isEmpty {
            filteredPokemon = pokemons
        } else {
            pokemons.forEach { poke in
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    filteredPokemon.append(poke)
                }
            }
        }
        
        self.tablePokemon.reloadData()
    }
}

// MARK: - Pokemon Manager Delegate

extension PokemonViewController: pokemonManagerDelegate {
    
    func showPokemonData(myList: [Pokemon]) {
        pokemons = myList
        
        DispatchQueue.main.async {
            self.filteredPokemon = myList
            self.tablePokemon.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tablePokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokemonCellTableViewCell
        else { return UITableViewCell() }
        
        let pokemon = filteredPokemon[indexPath.row]
        cell.configure(name: pokemon.name, id: pokemon.id)
        
        if let urlString = filteredPokemon[indexPath.row].imageUrl {
              if let imageURL = URL(string: urlString) {
                  
                DispatchQueue.global().async {
                    
                  guard let dataImage = try? Data(contentsOf: imageURL) else { return }
                  let image = UIImage(data: dataImage)
                    
                  DispatchQueue.main.async {
                      cell.setupImage(image)
                  }
                }
              }
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = filteredPokemon[indexPath.row]
        performSegue(withIdentifier: "showDetailsPokemon", sender: self)
        tablePokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsPokemon" {
            guard let showPokemonTrue = segue.destination as? PokemonDetailsViewController
            else { return }
            showPokemonTrue.showPokemon = selectedPokemon
        }
    }
    
    
}

