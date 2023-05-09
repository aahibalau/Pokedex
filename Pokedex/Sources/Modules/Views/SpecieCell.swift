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
      ZStack {
        RoundedRectangle(cornerRadius: 25)
          .fill(.white)
          .frame(width: 50, height: 50)
        RoundedRectangle(cornerRadius: 25)
          .stroke(.red, lineWidth: 1)
          .frame(width: 50, height: 50)
      }
      .overlay {
        AsyncImage(url: specie.iconUrl) { image in
          image.resizable()
            .aspectRatio(contentMode: .fit)
            .imageScale(.medium)
            .clipped()
        } placeholder: {
          Text("?")
            .font(.headline)
            .foregroundColor(.black)
        }
        .frame(width: 40, height: 40)
        .foregroundColor(.white)
      }
      Text(specie.name)
        .padding()
      Spacer()
    }
    .listRowSeparator(.hidden)
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
