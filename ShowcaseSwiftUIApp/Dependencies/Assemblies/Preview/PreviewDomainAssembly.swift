//
//  PreviewDomainAssembly.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

#if DEBUG

    import Foundation
    import ShowcaseDomain
    import ShowcaseDomainMocks
    import Swinject
    import SwinjectAutoregistration

    final class PreviewDomainAssembly: Assembly {
        func assemble(container: Container) {
            container.autoregister(
                GetBioUseCase.self,
                initializer: MockedGetBioUseCase.init
            )

            container.autoregister(
                GetAvatarUseCase.self,
                initializer: MockedGetAvatarUseCase.init
            )
        }
    }

#endif
