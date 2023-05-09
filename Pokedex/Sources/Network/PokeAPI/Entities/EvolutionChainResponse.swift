//
//  EvolutionChainResponse.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Foundation

struct EvolutionChainResponse: Decodable {
  class EvolutionChainItemResponse: Decodable {
    enum CodingKeys: String, CodingKey {
      case specie = "species"
      case evolutions = "evolves_to"
    }
    
    required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      self.species = try values.decode(SpeciesListItem.self, forKey: .specie)
      self.evolutions = try values.decode([EvolutionChainItemResponse].self, forKey: .evolutions)
    }
    
    let species: SpeciesListItem
    let evolutions: [EvolutionChainItemResponse]
  }
  let chain: EvolutionChainItemResponse
}
