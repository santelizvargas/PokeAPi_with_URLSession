//
//  PokemonManager.swift
//  PokeApiUikit
//
//  Created by User-G04 on 8/26/22.
//

import Foundation

protocol pokemonManagerDelegate {
    func showPokemonData(myList: [Pokemon])
}

struct PokemonManager {
    var delegate: pokemonManagerDelegate?
    
    func showPokemon() {
    let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, answer, error in
                if error != nil {
                    print("error getting api data: ", error?.localizedDescription ?? 0)
                }
                
                if let secureData = data?.parseData(removeString: "null,") {
                    if let pokemonList = self.parseJSON(pokemonData: secureData) {
                        print("lista de pokemones: ", pokemonList)
                        delegate?.showPokemonData(myList: pokemonList)
                        
                    }
                }
              
            }
            task.resume()
        }
    }
    func parseJSON(pokemonData: Data) -> [Pokemon]? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([Pokemon].self, from: pokemonData)
            return decodedData
        } catch {
            print("error decoder data: ", error.localizedDescription)
            return nil
        }
    }
}

extension Data {
    func parseData (removeString wordReplace: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: wordReplace, with: "")
        
        guard let data = parseDataString?.data(using: .utf8) else {
            return nil
        }
        
        return data
    }
}
