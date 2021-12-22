//
//  EnvironmentValues+AppResolver.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 22/12/2021.
//

import SwiftUI
import Swinject

struct DependenciesResolverKey: EnvironmentKey {
    static var defaultValue: Resolver = AppResolver.default
}

extension EnvironmentValues {
    var dependenciesResolver: Resolver {
        get { self[DependenciesResolverKey.self] }
        set { self[DependenciesResolverKey.self] = newValue }
    }
}
