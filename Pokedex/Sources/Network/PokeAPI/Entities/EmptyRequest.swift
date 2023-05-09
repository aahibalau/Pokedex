//
//  EmptyRequest.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

struct EmptyRequest: URLEncodable {
  func queryParameters() -> [String : String] { [:] }
}
