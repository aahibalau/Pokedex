//
//  SpecieImageView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

struct SpecieImageView: View {
  let imageUrl: URL?
  let width: Double
  let height: Double
  
  var body: some View {
    AsyncImage(url: imageUrl) { image in
      image.resizable()
        .aspectRatio(contentMode: .fit)
        .scaledToFit()
        .clipped()
    } placeholder: {
      Text("?")
        .font(.system(size: min(height, width) * 0.6))
        .foregroundColor(.black)
    }
    .frame(width: width, height: height)
  }
}

struct SpecieImageView_Previews: PreviewProvider {
  static var previews: some View {
    SpecieImageView(imageUrl: nil, width: 40, height: 40)
  }
}
