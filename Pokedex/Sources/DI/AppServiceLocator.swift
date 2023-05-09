//
//  AppServiceLocator.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Swinject

class AppServiceLocator {

  static let shared = configuredServiceLocator()

  let container: Container

  private class func configuredServiceLocator() -> AppServiceLocator {
    let serviceLocator = AppServiceLocator(container: Container())
    return serviceLocator
  }

  init(container: Container) {
    self.container = container

    registerApiClient(with: container)
    registerRepositories(with: container)
    registerUseCases(with: container)
    registerViewModels(with: container)
  }
}

extension AppServiceLocator: ServiceLocator {
  func resolve<Service>(_ serviceType: Service.Type) -> Service {
    guard let service = container.resolve(serviceType) else {
      fatalError("Please, register all your services, especially \(serviceType)")
    }
    return service
  }

  func resolve<Service, Arg>(_ serviceType: Service.Type, argument: Arg) -> Service {
    guard let service = container.resolve(serviceType, argument: argument) else {
      fatalError("Please, register all your services, especially \(serviceType)")
    }
    return service
  }
}

extension AppServiceLocator {
  func registerUseCases(with container: Container) {
    container.register(SpecieDetailsUseCase.self) { resolver in
      SpecieDetailsUseCaseInteractor(repo: resolver.resolve(SpecieRepository.self)!)
    }
  }

  func registerRepositories(with container: Container) {
    container.register(SpeciesRepository.self) { resolver in
      BaseSpeciesRepository(
        apiClient: resolver.resolve(ApiClient.self)!,
        endpointFactory: PokeApiEndpointFactory())
    }
    container.register(SpecieRepository.self) { resolver in
      BaseSpecieRepository(
        apiClient: resolver.resolve(ApiClient.self)!,
        endpointFactory: PokeApiEndpointFactory())
    }
  }

  func registerApiClient(with container: Container) {
    container.register(ApiClient.self) { resolver in
      URLSessionApiClient(apiConfiguration: resolver.resolve(ApiConfiguration.self)!)
    }
    .inObjectScope(.container)
    container.register(ApiConfiguration.self) { _ in
      PokeApiConfiguration()
    }
  }
  
  func registerViewModels(with container: Container) {
    container.register(SpeciesListViewModel.self) { resolver in
      SpeciesListViewModel(repository: resolver.resolve(SpeciesRepository.self)!, serviceLocator: AppServiceLocator.shared)
    }
    container.register(SpecieDetailsViewModel.self) { (resolver, id: String) in
      SpecieDetailsViewModel(id: id, useCase: resolver.resolve(SpecieDetailsUseCase.self)!)
    }
  }
}
