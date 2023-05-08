//
//  EndpointConfiguration.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

protocol EndpointConfiguration {
  var path: String { get }
  var method: Method { get }
}

enum Method: String {
  case get = "GET"
}
