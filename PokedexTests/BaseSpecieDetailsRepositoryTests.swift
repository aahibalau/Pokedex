//
//  BaseSpecieDetailsRepositoryTests.swift
//  PokedexTests
//
//  Created by Andrei Ahibalau on 08/05/2023.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
import Combine
@testable import Pokedex

final class BaseSpecieDetailsRepositoryTests: XCTestCase {
  
  var sut: BaseSpecieDetailsRepository!
  var bag: AnyCancellable?
  
  override func setUpWithError() throws {
    sut = BaseSpecieDetailsRepository(apiClient: URLSessionApiClient(apiConfiguration: PokeApiConfiguration()), endpointFactory: PokeApiEndpointFactory())
  }
  
  override func tearDownWithError() throws {
    sut = nil
    bag = nil
  }
  
  func testSpecieDetailsSuccess() throws {
    let expectation = self.expectation(description: "Fullfilled")
    stub(condition: isHost("pokeapi.co")) { request -> HTTPStubsResponse in
      HTTPStubsResponse(fileAtPath: OHPathForFile("specieDetails.json", type(of: self))!, statusCode: 200, headers: nil)
    }
    bag = sut.specie(with: "")
      .sink { completion in
        switch completion {
        case let .failure(error):
          XCTFail(error.localizedDescription)
        default:
          break
        }
        expectation.fulfill()
      } receiveValue: { response in
        XCTAssertEqual(response.id, 133)
        XCTAssertEqual(response.name, "Eevee")
        XCTAssertEqual(response.evolutionChainId, "67")
      }

    waitForExpectations(timeout: 1) { error in
      HTTPStubs.removeAllStubs()
    }
  }
  
  func testSpecieDetailsFailure() throws {
    let expectation = self.expectation(description: "Fullfilled")
    stub(condition: isHost("pokeapi.co")) { request -> HTTPStubsResponse in
      let responseJSON = "{}"
      let stubData = responseJSON.data(using: String.Encoding.utf8)
      return HTTPStubsResponse(data:stubData!, statusCode:200, headers:nil)
    }
    bag = sut.specie(with: "")
      .sink { completion in
        switch completion {
        case .failure:
          expectation.fulfill()
          
        default:
          XCTFail()
        }
      } receiveValue: { response in
        XCTFail()
      }

    waitForExpectations(timeout: 1) { error in
      HTTPStubs.removeAllStubs()
    }
  }
  
  func testEvoulutionChainSuccess() throws {
    let expectation = self.expectation(description: "Fullfilled")
    stub(condition: isHost("pokeapi.co")) { request -> HTTPStubsResponse in
      HTTPStubsResponse(fileAtPath: OHPathForFile("evolutionChain.json", type(of: self))!, statusCode: 200, headers: nil)
    }
    bag = sut.evolutionChain(with: "")
      .sink { completion in
        switch completion {
        case let .failure(error):
          XCTFail(error.localizedDescription)
        default:
          break
        }
        expectation.fulfill()
      } receiveValue: { response in
        XCTAssertEqual(response.chain.species.name, "eevee")
        XCTAssertEqual(response.chain.evolutions.count, 8)
      }

    waitForExpectations(timeout: 1) { error in
      HTTPStubs.removeAllStubs()
    }
  }
  
  func testEvoulutionChainFailure() throws {
    let expectation = self.expectation(description: "Fullfilled")
    stub(condition: isHost("pokeapi.co")) { request -> HTTPStubsResponse in
      let responseJSON = "{}"
      let stubData = responseJSON.data(using: String.Encoding.utf8)
      return HTTPStubsResponse(data:stubData!, statusCode:200, headers:nil)
    }
    bag = sut.evolutionChain(with: "")
      .sink { completion in
        switch completion {
        case .failure:
          expectation.fulfill()
        default:
          XCTFail()
        }
      } receiveValue: { response in
        XCTFail()
      }

    waitForExpectations(timeout: 1) { error in
      HTTPStubs.removeAllStubs()
    }
  }
  
}
