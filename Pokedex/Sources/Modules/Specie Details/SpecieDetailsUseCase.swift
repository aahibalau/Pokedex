//
//  SpecieDetailsUseCase.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Foundation
import Combine

struct SpecieDetails {
  let id: Int
  let name: String
  let frontImageUrl: URL?
  let backImageUrl: URL?
  let evoulutionChainId: String
}

extension SpecieDetails {
  init(specieResponse: SpecieResponse) {
    self.id = specieResponse.id
    self.name = specieResponse.name
    self.evoulutionChainId = specieResponse.evolutionChainId
    self.frontImageUrl = URL(string: String(format: CommonConstant.frontImageUrlTemplate, String(specieResponse.id)))
    self.backImageUrl = URL(string: String(format: CommonConstant.backImageUrlTemplate, String(specieResponse.id)))
  }
}

protocol SpecieDetailsUseCase {
  func loadSpecie(with id: String) -> AnyPublisher<SpecieDetails, ApiError>
  func loadEvoulutionChain(with id: String, for specieId: String) -> AnyPublisher<[[SpeciesPresentableListItem]], ApiError>
}

struct SpecieDetailsUseCaseInteractor: SpecieDetailsUseCase {
  let repo: SpecieRepository
  
  init(repo: SpecieRepository) {
    self.repo = repo
  }
  
  func loadSpecie(with id: String) -> AnyPublisher<SpecieDetails, ApiError> {
    repo.specie(with: id)
      .map(SpecieDetails.init(specieResponse: ))
      .eraseToAnyPublisher()
  }
  
  func loadEvoulutionChain(with id: String, for specieId: String) -> AnyPublisher<[[SpeciesPresentableListItem]], ApiError> {
    repo.evolutionChain(with: id)
      .map { response -> [[SpeciesPresentableListItem]] in
        func flattenEvolution(for chain: EvolutionChainResponse.EvolutionChainItemResponse, hasCurrent: Bool) -> [[SpeciesPresentableListItem]]? {
          guard let specie = SpeciesPresentableListItem(specie: chain.species, checkToHighlighted: { $0 == specieId }) else { return nil }
          let isCurrentBranch = specie.id == specieId || hasCurrent
          if chain.evolutions.isEmpty {
            if isCurrentBranch {
              return [[specie]]
            } else {
              return nil
            }
          } else {
            return chain.evolutions.compactMap { flattenEvolution(for: $0, hasCurrent: isCurrentBranch) }
              .flatMap { $0 }
              .map { [specie] + $0 }
          }
        }
        
        return flattenEvolution(for: response.chain, hasCurrent: false) ?? []
      }
      .eraseToAnyPublisher()
  }
}
