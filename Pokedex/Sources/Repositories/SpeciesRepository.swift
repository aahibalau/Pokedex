//
//  SpeciesRepository.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation
import Combine

protocol SpeciesRepository {
  func speciesPage(offset: Int) -> AnyPublisher<PageResponse<SpeciesListItem>, ApiError>
}

struct BaseSpeciesRepository: SpeciesRepository {
  enum Constant {
    static let pageLimit = 20
  }
  let apiClient: ApiClient
  let endpointFactory: EndpointFactory
  
  init(apiClient: ApiClient, endpointFactory: EndpointFactory) {
    self.endpointFactory = endpointFactory
    self.apiClient = apiClient
  }
  
  func speciesPage(offset: Int) -> AnyPublisher<PageResponse<SpeciesListItem>, ApiError> {
    apiClient.sendRequest(to: endpointFactory.getSpeciesPage(offset: offset, limit: Constant.pageLimit))
  }
}
