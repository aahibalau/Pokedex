//
//  SpecieDetailsView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

struct SpecieDetailsView: View {
  private enum Constant {
    static let cardAspectRatio: CGFloat = 0.7
    static let cardsSpacing: CGFloat = 30
    static let imagesSectionHeight: CGFloat = 200
    static let evolutionSectionHeight: CGFloat = 120
    
    static func evolutionScaleEffect(_ isHighlighted: Bool) -> CGSize {
      let scale = isHighlighted ? 1.2 : 1
      return CGSize(width: scale, height: scale)
    }
  }
  @ObservedObject private var viewModel: SpecieDetailsViewModel
  
  init(viewModel: SpecieDetailsViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      if let species = viewModel.specie {
        content(for: species)
      } else {
        ProgressView()
          .onAppear {
            viewModel.laodData()
          }
      }
    }
  }
  
  func content(for specie: SpecieDetails) -> some View {
    ScrollView {
      VStack {
        specieImages(for: specie)
        HStack {
          Text("Evolution chains")
            .font(.subheadline)
          Spacer()
        }
        .padding()
        evolutionChain
      }
    }
    .navigationTitle(viewModel.specie?.name ?? "Who is that pokemon?")
  }
  
  func specieImages(for specie: SpecieDetails) -> some View {
    HStack(alignment: .center, spacing: Constant.cardsSpacing) {
      let cardHeight: CGFloat = Constant.imagesSectionHeight
      let cardWidth = cardHeight * Constant.cardAspectRatio
      SpecieCardImageView(iconUrl: specie.frontImageUrl, width: cardWidth, height: cardHeight, cornerRadius: 20)
      SpecieCardImageView(iconUrl: specie.backImageUrl, width: cardWidth, height: cardHeight, cornerRadius: 20)
    }
  }
  
  @ViewBuilder var evolutionChain: some View {
    if viewModel.isEvolutionLoading {
      HStack(alignment: .center) {
        ProgressView()
      }
    } else {
      ForEach(0..<viewModel.evolutions.count, id: \.self) { index in
        ScrollView {
          HStack(spacing: Constant.cardsSpacing) {
            ForEach(viewModel.evolutions[index]) { item in
              VStack {
                SpecieCardImageView(
                  iconUrl: item.iconUrl,
                  width: CommonConstant.cardSize,
                  height: CommonConstant.cardSize,
                  cornerRadius: CommonConstant.cornerRadius)
                Text(item.name)
              }
              .scaleEffect(Constant.evolutionScaleEffect(item.isHighlighted))
            }
          }
          .frame(height: Constant.evolutionSectionHeight)
          .frame(maxWidth: .infinity)
        }
      }
    }
  }
}

