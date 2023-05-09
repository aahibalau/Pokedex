//
//  ApiClient.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation
import Combine

protocol ApiClient {
  func sendRequest<RequestEndpoint: Endpoint>(
    to endpoint: RequestEndpoint
  ) -> AnyPublisher<RequestEndpoint.Response, ApiError>
}

enum ApiError: Error {
  case encode(EncodeError)
  case reqest(URLError)
  case decode(DecodingError)
  case undefined
  case notFound
  
}
