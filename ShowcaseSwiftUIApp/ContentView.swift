//
//  ContentView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

import SwiftUI
import Swinject
import SwinjectAutoregistration

struct ContentView: View {
    let resolver: Resolver

    var body: some View {
        BioPageView(
            viewModel: resolver~>)
    }
}

#if DEBUG

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(resolver: AppResolver.preview)
        }
    }

#endif
