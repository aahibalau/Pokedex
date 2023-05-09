//
//  SpeciesListView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import SwiftUI

struct SpeciesListView: View {
  @ObservedObject private var viewModel: SpeciesListViewModel
  
  init(viewModel: SpeciesListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationStack {
      if viewModel.isLoading && viewModel.species.isEmpty {
        ProgressView()
      } else {
        ScrollView {
          LazyVStack {
            ForEach(viewModel.species) { specie in
              NavigationLink(value: specie.id) {
                SpecieCell(specie: specie)
              }
              .padding(horiztontal: CommonConstant.padding)
            }
            if viewModel.hasNext {
              ProgressView()
                .frame(maxWidth: .infinity)
                .padding()
                .onAppear { viewModel.loadData() }
            }
          }
        }
        .listStyle(.plain)
        .navigationTitle("Species")
        .navigationDestination(for: String.self) { id in
          SpecieDetailsView(viewModel: viewModel.detailsViewModel(with: id))
        }
      }
    }
    .onAppear {
      viewModel.loadData()
    }
  }
}
