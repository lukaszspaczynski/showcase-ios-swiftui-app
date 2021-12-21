//
//  AppResolver.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

import Foundation
import Swinject

enum AppResolver {
    static var `default`: Resolver = {
        AssemblerFactory.default.resolver
    }()
}
