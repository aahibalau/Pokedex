//
//  SpecieRepository.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Foundation
import Combine

protocol SpecieRepository {
  func specie(with id: String) -> AnyPublisher<SpecieResponse, ApiError>
  func evolutionChain(with id: String) -> AnyPublisher<EvolutionChainResponse, ApiError>
}

struct BaseSpecieRepository: SpecieRepository {
  let apiClient: ApiClient
  let endpointFactory: EndpointFactory
  
  init(apiClient: ApiClient, endpointFactory: EndpointFactory) {
    self.endpointFactory = endpointFactory
    self.apiClient = apiClient
  }
  
  func specie(with id: String) -> AnyPublisher<SpecieResponse, ApiError> {
    apiClient.sendRequest(to: endpointFactory.getSpecieDetails(id: id))
  }
  
  func evolutionChain(with id: String) -> AnyPublisher<EvolutionChainResponse, ApiError> {
    apiClient.sendRequest(to: endpointFactory.getEvolutionChain(id: id))
  }
}
