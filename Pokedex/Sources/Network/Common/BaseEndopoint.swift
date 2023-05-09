//
//  BaseEndopoint.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation

struct BaseEndopoint<RequestParameters, Response>: Endpoint {
  let configuration: EndpointConfiguration
  let parameters: RequestParameters

  let encoder: (inout URLRequest, RequestParameters) throws -> Void
  let decoder: (Data) throws -> Response

  func encode(request: inout URLRequest) throws {
    guard let baseUrl = request.url,
      let pathUrl = URL(string: configuration.path, relativeTo: baseUrl) else {
      throw EncodeError.emptyUrl
    }
    request.url = pathUrl
    try encoder(&request, parameters)
  }

  func decode(data: Data) throws -> Response {
    try decoder(data)
  }
}
