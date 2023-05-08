//
//  URLEncodable.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

protocol URLEncodable {
  func queryParameters() -> [String: String]
}
