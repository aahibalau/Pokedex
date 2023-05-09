//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import SwiftUI

@main
struct PokedexApp: App {
  private let serviceLocator: ServiceLocator = AppServiceLocator.shared
  var body: some Scene {
    WindowGroup {
      SpeciesListView(viewModel: serviceLocator.resolve(SpeciesListViewModel.self))
    }
  }
}
