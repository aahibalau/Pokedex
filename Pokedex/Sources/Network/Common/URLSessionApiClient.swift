//
//  URLSessionApiClient.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation
import Combine

struct URLSessionApiClient: ApiClient {
  private let apiConfiguration: ApiConfiguration
  private let urlSession = URLSession(configuration: .default)

  init(apiConfiguration: ApiConfiguration) {
    self.apiConfiguration = apiConfiguration
    urlSession.configuration.timeoutIntervalForRequest = 20
  }

  // MARK: - Send Request

  func sendRequest<RequestEndpoint>(
    to endpoint: RequestEndpoint
  ) -> AnyPublisher<RequestEndpoint.Response, ApiError> where RequestEndpoint : Endpoint {
    createRequest(for: endpoint)
      .flatMap(maxPublishers: .max(1)) {
        urlSession.dataTaskPublisher(for: $0)
          .mapError { ApiError.reqest($0) }
          .eraseToAnyPublisher()
      }
      .tryMap { try endpoint.decode(data: $0.data) }
      .mapError {
        switch $0 {
        case let apiError as ApiError: return apiError
        case let decodingError as DecodingError: return ApiError.decode(decodingError)
        default: return ApiError.undefined
        }
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  // MARK: - Private

  private func createRequest<RequestEndpoint: Endpoint>(
    for endpoint: RequestEndpoint
  ) -> AnyPublisher<URLRequest, ApiError> {
    Just(URLRequest(url: baseUrl))
      .tryMap {
        var request = $0
        request.httpMethod = endpoint.configuration.method.rawValue
        try endpoint.encode(request: &request)
        return request
      }
      .mapError {
        switch $0 {
        case let encodeError as EncodeError:
          return ApiError.encode(encodeError)
        default:
          return ApiError.undefined
        }
      }
      .eraseToAnyPublisher()
  }

  // MARK: - URL

  private var baseUrl: URL {
    URL(string: apiConfiguration.baseUrlString)!
  }
}
