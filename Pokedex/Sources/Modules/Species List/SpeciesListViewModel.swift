//
//  SpeciesListViewModel.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation
import Combine

class SpeciesListViewModel: ObservableObject {
  private let repository: SpeciesRepository
  private let serviceLocator: ServiceLocator
  
  @Published var species: [SpeciesPresentableListItem] = []
  @Published var hasNext: Bool = false
  @Published var isLoading: Bool = false
  @Published var errorText: String? = nil
  var bag = Set<AnyCancellable>()
  private var selectedSpecie: SpecieDetailsViewModel?
  
  init(repository: SpeciesRepository, serviceLocator: ServiceLocator) {
    self.repository = repository
    self.serviceLocator = serviceLocator
  }
  
  func loadData() {
    guard !isLoading else { return }
    isLoading = true
    repository.speciesPage(offset: species.count)
      .sink { [weak self] completion in
        self?.isLoading = false
        switch completion {
        case let .failure(error):
          print(error.localizedDescription)
          if self?.species.count == 0 {
            self?.errorText = "Something Went Wrong"
          }
        default: return
        }
      } receiveValue: { [weak self] response in
        self?.isLoading = false
        self?.species.append(
          contentsOf: response.results.compactMap(SpeciesPresentableListItem.init(specie: )))
        self?.hasNext = response.hasNext
      }
      .store(in: &bag)
  }
  
  func detailsViewModel(with id: String) -> SpecieDetailsViewModel {
    if let selectedSpecie = self.selectedSpecie, selectedSpecie.specieId == id {
      return selectedSpecie
    }
    let selectedSpecie = serviceLocator.resolve(SpecieDetailsViewModel.self, argument: id)
    self.selectedSpecie = selectedSpecie
    return selectedSpecie
  }
}
