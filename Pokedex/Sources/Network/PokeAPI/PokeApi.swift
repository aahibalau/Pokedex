//
//  PokeApi.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

enum PokeApi {
  case speciesPage
}

extension PokeApi: EndpointConfiguration {
  private var commonPath: String { "/api/v2/" }
  
  var path: String {
    switch self {
    case .speciesPage: return commonPath + "pokemon-species"
    }
  }
  
  var method: Method { .get }
}
