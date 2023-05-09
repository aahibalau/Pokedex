//
//  SpeciesListView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import SwiftUI

struct SpeciesListView: View {
  @ObservedObject private var viewModel: SpeciesListViewModel = SpeciesListViewModel(repository: BaseSpeciesRepository.repo)
  
//  init(viewModel: SpeciesListViewModel) {
//    self.viewModel = viewModel
//  }
  
  var body: some View {
    NavigationStack {
      if viewModel.isLoading && viewModel.species.isEmpty {
        ProgressView()
      } else {
        List {
          ForEach(viewModel.species) { specie in
            SpecieCell(specie: specie)
          }
          if viewModel.hasNext {
            ProgressView()
              .frame(height: 40)
              .frame(maxWidth: .infinity)
              .onAppear { viewModel.loadData() }
              .listRowSeparator(.hidden)
          }
        }
        .listStyle(.plain)
        .navigationTitle("Species")
      }
    }
    .onAppear {
      viewModel.loadData()
    }
  }
}

struct SpeciesListView_Previews: PreviewProvider {
  static var previews: some View {
    SpeciesListView()
  }
}
