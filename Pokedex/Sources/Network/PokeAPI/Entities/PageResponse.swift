//
//  PageResponse.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

struct PageResponse<Content: Codable>: Codable {
  let count: Int
  let results: [Content]
  let next: String?
  
  var hasNext: Bool {
    next != nil
  }
}
