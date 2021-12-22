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
    @Environment(\.dependenciesResolver) private var resolver

    var body: some View {
        NavigationView {
            AvatarPageView(
                viewModel: resolver~>)
        }
    }
}

#if DEBUG

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environment(\.dependenciesResolver, AppResolver.preview)
        }
    }

#endif
