//
//  AssemblerFactory+Preview.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

#if DEBUG

    import Foundation
    import Swinject

    extension AssemblerFactory {
        static var preview: Assembler = {
            let cantainerAssemblies: [Assembly] = [
                PreviewDataAssembly(),
                PreviewDomainAssembly(),
            ]

            let cantainerAssembler = Assembler(
                cantainerAssemblies,
                parent: nil,
                defaultObjectScope: .container
            )

            let transientAssemblies: [Assembly] = [
                ViewModelAssembly(),
            ]

            let transientAssembler = Assembler(
                transientAssemblies,
                parent: cantainerAssembler,
                defaultObjectScope: .transient
            )

            return transientAssembler
        }()
    }

#endif
