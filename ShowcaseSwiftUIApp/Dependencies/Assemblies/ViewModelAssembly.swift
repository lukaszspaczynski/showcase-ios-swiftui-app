//
//  ViewModelAssembly.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
            AvatarPageView.ViewModel.self,
            initializer: AvatarPageView.ViewModel.init
        )

        container.autoregister(
            BioPageView.ViewModel.self,
            initializer: BioPageView.ViewModel.init
        )
    }
}
