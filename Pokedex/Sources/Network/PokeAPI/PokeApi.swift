//
//  PokeApi.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

enum PokeApi {
  case speciesPage
  case specieDetails(id: String)
  case evolutionChain(id: String)
}

extension PokeApi: EndpointConfiguration {
  private var commonPath: String { "/api/v2/" }
  
  var path: String {
    switch self {
    case .speciesPage: return commonPath + "pokemon-species"
    case let .specieDetails(id): return commonPath + "pokemon-species/\(id)/"
    case let .evolutionChain(id): return commonPath + "evolution-chain/\(id)/"
    }
  }
  
  var method: Method { .get }
}
