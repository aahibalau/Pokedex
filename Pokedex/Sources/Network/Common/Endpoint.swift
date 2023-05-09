//
//  Endpoint.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation

protocol Endpoint {
  associatedtype Response

  var configuration: EndpointConfiguration { get }

  func encode(request: inout URLRequest) throws
  func decode(data: Data) throws -> Response
}
