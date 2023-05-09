//
//  PokeApiEndpointFactory.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation

protocol EndpointFactory {
  func getSpeciesPage(offset: Int, limit: Int) -> BaseEndopoint<SpeciesPageRequest, PageResponse<SpeciesListItem>>
  func getSpecieDetails(id: String) -> BaseEndopoint<EmptyRequest, SpecieResponse>
  func getEvolutionChain(id: String) -> BaseEndopoint<EmptyRequest, EvolutionChainResponse>
}

class PokeApiEndpointFactory: EndpointFactory {
  func urlEncodedBaseEndpoint<Request: URLEncodable, Response: Decodable>(with endpoint: EndpointConfiguration, parameters: Request) -> BaseEndopoint<Request, Response> {
    BaseEndopoint(
      configuration: endpoint,
      parameters: parameters,
      encoder: EncoderFactory.urlEncodeFunction(),
      decoder: DecoderFactory.apiJsonDecodeFunction(with: JSONDecoder()))
  }
  
  func getSpeciesPage(offset: Int, limit: Int) -> BaseEndopoint<SpeciesPageRequest, PageResponse<SpeciesListItem>> {
    urlEncodedBaseEndpoint(with: PokeApi.speciesPage, parameters: SpeciesPageRequest(offset: offset, limit: limit))
  }
  
  func getSpecieDetails(id: String) -> BaseEndopoint<EmptyRequest, SpecieResponse> {
    urlEncodedBaseEndpoint(with: PokeApi.specieDetails(id: id), parameters: EmptyRequest())
  }
  
  func getEvolutionChain(id: String) -> BaseEndopoint<EmptyRequest, EvolutionChainResponse> {
    urlEncodedBaseEndpoint(with: PokeApi.evolutionChain(id: id), parameters: EmptyRequest())
  }
}
