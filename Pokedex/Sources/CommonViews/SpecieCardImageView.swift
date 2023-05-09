//
//  SpecieCardImageView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

struct SpecieCardImageView: View {
  let iconUrl: URL?
  let width: CGFloat
  let height: CGFloat
  let cornerRadius: CGFloat
  
  var imageSize: CGFloat {
    min(height, width) * 0.9
  }
  
  var body: some View {
    CardView(width: width, height: height, cornerRadius: cornerRadius)
      .overlay {
        SpecieImageView(imageUrl: iconUrl, width: imageSize, height: imageSize)
      }
  }
}
