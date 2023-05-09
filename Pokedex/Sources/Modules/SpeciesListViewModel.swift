//
//  SpeciesListViewModel.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation
import Combine

class SpeciesListViewModel: ObservableObject {
  let repository: SpeciesRepository
  
  @Published var species: [SpeciesPresentableListItem] = []
  @Published var hasNext: Bool = false
  @Published var isLoading: Bool = false
  var bag = Set<AnyCancellable>()
  
  init(repository: SpeciesRepository) {
    self.repository = repository
  }
  
  func loadData() {
    guard !isLoading else { return }
    isLoading = true
    repository.getSpeciesPage(offset: species.count)
      .sink { [weak self] completion in
        self?.isLoading = false
        switch completion {
        case let .failure(error): print(error.localizedDescription)
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
  
}
