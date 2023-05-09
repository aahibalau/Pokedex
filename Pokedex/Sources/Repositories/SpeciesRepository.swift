//
//  SpeciesRepository.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation
import Combine

protocol SpeciesRepository {
  func getSpeciesPage(offset: Int) -> AnyPublisher<PageResponse<SpeciesListItem>, ApiError>
}

struct BaseSpeciesRepository: SpeciesRepository {
  static var repo: BaseSpeciesRepository {
    BaseSpeciesRepository(apiClient: URLSessionApiClient(apiConfiguration: PokeApiConfiguration()), endpointFactory: PokeApiEndpointFactory())
  }
  
  enum Constant {
    static let pageLimit = 20
  }
  let apiClient: ApiClient
  let endpointFactory: EndpointFactory
  
  init(apiClient: ApiClient, endpointFactory: EndpointFactory) {
    self.endpointFactory = endpointFactory
    self.apiClient = apiClient
  }
  
  func getSpeciesPage(offset: Int) -> AnyPublisher<PageResponse<SpeciesListItem>, ApiError> {
    apiClient.sendRequest(to: endpointFactory.getSpeciesPage(offset: offset, limit: Constant.pageLimit))
  }
}
