//
//  SpecieCardImageView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

struct SpecieCardImageView: View {
  private enum Constant {
    static let scaleFactor: CGFloat = 0.8
  }
  let iconUrl: URL?
  let width: CGFloat
  let height: CGFloat
  let cornerRadius: CGFloat
  
  var imageSize: CGFloat {
    min(height, width) * Constant.scaleFactor
  }
  
  var body: some View {
    CardView(width: width, height: height, cornerRadius: cornerRadius)
      .overlay {
        SpecieImageView(imageUrl: iconUrl, width: imageSize, height: imageSize)
          .frame(width: imageSize, height: imageSize)
      }
  }
}
