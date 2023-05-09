//
//  ServiceLocator.swift
//  Pokedex
//
//  Created by Andrei Ahibalau on 09/05/2023.
//

import Swinject

protocol ServiceLocator {
  func resolve<Service>(_ serviceType: Service.Type) -> Service
  func resolve<Service, Arg>(_ serviceType: Service.Type, argument: Arg) -> Service
}
