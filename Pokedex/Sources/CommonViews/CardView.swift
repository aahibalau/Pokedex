//
//  CardView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

struct CardView: View {
  let width: Double
  let height: Double
  let cornerRadius: Double
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .fill(.white)
      RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(.red, lineWidth: 1)
    }
    .frame(width: width, height: height)
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(width: 80, height: 120, cornerRadius: 20)
  }
}
