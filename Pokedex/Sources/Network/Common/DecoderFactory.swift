//
//  DecoderFactory.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import Foundation

enum DecoderFactory {
  static func apiJsonDecodeFunction<ResponseObject: Decodable>(
    with decoder: JSONDecoder
  ) -> (Data) throws -> ResponseObject {
    { (data: Data) throws -> ResponseObject in
      try decoder.decode(ResponseObject.self, from: data)
    }
  }
}
