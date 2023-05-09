//
//  SpecieDetailsView.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

struct SpecieDetailsView: View {
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
    HStack(alignment: .center, spacing: 20) {
      let cardHeight: CGFloat = 200
      let cardWidth = cardHeight * 0.7
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
          HStack(spacing: 20) {
            ForEach(viewModel.evolutions[index]) { item in
              VStack {
                SpecieCardImageView(iconUrl: item.iconUrl, width: 40, height: 40, cornerRadius: 20)
                Text(item.name)
              }
              .scaleEffect(CGSize(width: item.isHighlighted ? 1.2 : 1, height: item.isHighlighted ? 1.2 : 1))
            }
          }
          .frame(height: 120)
          .frame(maxWidth: .infinity)
        }
      }
    }
  }
}

