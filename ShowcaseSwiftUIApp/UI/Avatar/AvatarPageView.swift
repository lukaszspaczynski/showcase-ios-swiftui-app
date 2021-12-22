//
//  AvatarPageView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

import Combine
import RxSwift
import SwiftUI
import Swinject
import SwinjectAutoregistration

struct AvatarPageView: View {
    @Environment(\.dependenciesResolver) private var resolver
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Text(AttributedStringsRepository
                .welcome
                .attributed())
                .padding(.init(
                    top: 8,
                    leading: 16,
                    bottom: 16,
                    trailing: 16
                ))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
            Group {
                switch viewModel.viewState {
                case let .error(error):
                    ErrorView(error: error) {
                        viewModel.load(force: true)
                    }
                case .working:
                    WorkingView()
                case let .loaded(avatar):
                    AvatarView(avatar: avatar)
                }
            }
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    BioPageView(
                        viewModel: resolver~>)
                } label: {
                    Text(AttributedStringsRepository
                        .next
                        .attributed())
                        .padding(.init(
                            top: 8,
                            leading: 8,
                            bottom: 16,
                            trailing: 16
                        ))
                }
            }
        }.onAppear {
            viewModel.load()
        }
        .background(Colors.lightBlack)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

#if DEBUG

    struct AvatarPageView_Previews: PreviewProvider {
        static var previews: some View {
            AvatarPageView(viewModel: AppResolver.preview~>)
        }
    }

#endif
