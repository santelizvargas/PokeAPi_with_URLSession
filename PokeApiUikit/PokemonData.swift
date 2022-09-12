//
//  PokemonData.swift
//  PokeApiUikit
//
//  Created by User-G04 on 8/26/22.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let name: String
    let description: String
    let imageUrl: String?
    let type: String
}

