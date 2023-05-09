//
//  SpeciesPresentableListItem.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Foundation

struct SpeciesPresentableListItem: Equatable, Identifiable {
  var id: String { specieUrl.lastPathComponent }
  let name: String
  var specieUrl: URL
  var isHighlighted: Bool = false
  
  var iconUrl: URL? {
    return URL(string: String(format: CommonConstant.frontImageUrlTemplate, id))
  }
}

extension SpeciesPresentableListItem {
  init?(specie: SpeciesListItem) {
    self.init(specie: specie, checkToHighlighted: nil)
  }
  
  init?(specie: SpeciesListItem, checkToHighlighted: ((String) -> Bool)? = nil) {
    guard let specieUrl = URL(string: specie.url) else { return nil }
    name = specie.name.capitalized
    self.specieUrl = specieUrl
    self.isHighlighted = checkToHighlighted?(self.id) ?? false
  }
}
