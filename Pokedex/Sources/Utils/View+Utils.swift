//
//  View+utils.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import SwiftUI

extension View {
  @inlinable public func padding(horiztontal value: CGFloat) -> some View {
    padding([.leading, .trailing], value)
  }
}
