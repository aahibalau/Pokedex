//
//  SpecieResponse.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Foundation

struct SpecieResponse: Decodable {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case evoChain = "evolution_chain"
  }
  
  private struct EvolutionChainUrl: Decodable {
    let url: String
  }
  
  let id: Int
  let name: String
  let evolutionChainId: String
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try values.decode(Int.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name).capitalized
    let evolution = try values.decode(EvolutionChainUrl.self, forKey: .evoChain)
    guard let evoId = URL(string: evolution.url)?.lastPathComponent else {
      throw DecodingError.valueNotFound(String.self, .init(codingPath: [CodingKeys.evoChain], debugDescription: "Can't find id inside evolution chain url"))
    }
    self.evolutionChainId = evoId
  }
}
