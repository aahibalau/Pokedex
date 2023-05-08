//
//  SpeciesPageRequest.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

struct SpeciesPageRequest: URLEncodable {
  let offset: Int
  let limit: Int
  
  func queryParameters() -> [String : String] {
    ["offset": String(offset), "limit": String(limit)]
  }
}
