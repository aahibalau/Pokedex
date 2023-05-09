//
//  SpecieDetailsViewModel.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Foundation
import Combine

class SpecieDetailsViewModel: ObservableObject {
  @Published var specie: SpecieDetails?
  @Published var evolutions: [[SpeciesPresentableListItem]] = []
  @Published var isEvolutionLoading = false
  
  let specieId: String
  private let useCase: SpecieDetailsUseCase
  private var bag: Set<AnyCancellable> = []
  
  init(id: String, useCase: SpecieDetailsUseCase) {
    self.specieId = id
    self.useCase = useCase
  }
  
  func laodData() {
    useCase.loadSpecie(with: specieId)
      .sink { _ in } receiveValue: { [weak self] details in
        self?.specie = details
        self?.loadEvolutionChain(with: details.evoulutionChainId)
      }
      .store(in: &bag)

  }
  
  private func loadEvolutionChain(with chainId: String) {
    isEvolutionLoading = true
    useCase.loadEvoulutionChain(with: chainId, for: specieId)
      .sink { [weak self] completion in
        self?.isEvolutionLoading = false
      } receiveValue: { [weak self] items in
        self?.isEvolutionLoading = false
        self?.evolutions = items
      }
      .store(in: &bag)
  }
}
