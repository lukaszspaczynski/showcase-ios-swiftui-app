//
//  AppResolver+Preview.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

#if DEBUG

    import Foundation
    import Swinject

    extension AppResolver {
        static var preview: Resolver = {
            AssemblerFactory.preview.resolver
        }()
    }

#endif
