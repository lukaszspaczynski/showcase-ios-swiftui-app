//
//  PreviewDataAssembly.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

#if DEBUG

    import Foundation
    import ShowcaseData
    import Swinject
    import SwinjectAutoregistration

    final class PreviewDataAssembly: Assembly {
        func assemble(container: Container) {
            container.register(BioWebEndpoint.self) { _ in Endpoints.shared }
            container.register(AvatarEndpoint.self) { _ in Endpoints.shared }
        }
    }

#endif
