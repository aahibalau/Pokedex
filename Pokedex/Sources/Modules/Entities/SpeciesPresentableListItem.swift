//
//  SpeciesPresentableListItem.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Foundation

struct SpeciesPresentableListItem: Equatable, Identifiable {
  private enum Constant {
    static let imageUrlTemplate = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/%@.png"
  }
  var id: String { specieUrl.lastPathComponent }
  let name: String
  var specieUrl: URL
  
  var iconUrl: URL? {
    return URL(string: String(format: Constant.imageUrlTemplate, id))
  }
}

extension SpeciesPresentableListItem {
  init?(specie: SpeciesListItem) {
    guard let specieUrl = URL(string: specie.url) else { return nil }
    name = specie.name.capitalized
    self.specieUrl = specieUrl
  }
}
