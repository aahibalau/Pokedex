//
//  PokeApiEndpointFactory.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation

protocol EndpointFactory {
  func getSpeciesPage(offset: Int, limit: Int) -> BaseEndopoint<SpeciesPageRequest, PageResponse<SpeciesListItem>>
}

class PokeApiEndpointFactory: EndpointFactory {
  func getSpeciesPage(offset: Int, limit: Int) -> BaseEndopoint<SpeciesPageRequest, PageResponse<SpeciesListItem>> {
    BaseEndopoint(
      configuration: PokeApi.speciesPage,
      parameters: SpeciesPageRequest(offset: offset, limit: limit),
      encoder: EncoderFactory.urlEncodeFunction(),
      decoder: DecoderFactory.apiJsonDecodeFunction(with: JSONDecoder()))
  }
}
