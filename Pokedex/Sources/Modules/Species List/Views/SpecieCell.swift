//
//  SpecieCell.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

struct SpecieCell: View {
  private let specie: SpeciesPresentableListItem
  
  init(specie: SpeciesPresentableListItem) {
    self.specie = specie
  }
  
  var body: some View {
    HStack {
      SpecieCardImageView(iconUrl: specie.iconUrl, width: 50, height: 50, cornerRadius: 25)
      Text(specie.name)
        .padding()
      Spacer()
      Text("id: \(specie.id)")
    }
  }
}

struct SpecieCell_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      SpecieCell(
        specie: SpeciesPresentableListItem(
          name: "Bulbasaur",
          specieUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!))
    }
  }
}
