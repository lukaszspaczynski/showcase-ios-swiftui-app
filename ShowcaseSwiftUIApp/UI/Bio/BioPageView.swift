//
//  BioPageView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 20/12/2021.
//

import SwiftUI

struct BioPageView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Group {
                switch viewModel.viewState {
                case let .error(error):
                    ErrorView(error: error)
                case .working:
                    WorkingView()
                case let .loaded(bio):
                    BioView(bio: bio)
                }
            }
            Spacer()
            HStack {
                Text(AttributedStringsRepository
                    .prev
                    .attributed())
                    .padding(.init(
                        top: 8,
                        leading: 16,
                        bottom: 16,
                        trailing: 8
                    ))
                Spacer()
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
        }.onAppear {
            viewModel.load()
        }.background(Colors.lightBlack)
    }
}

extension BioPageView {
    private struct ErrorView: View {
        let error: Error

        var body: some View {
            VStack {
                Spacer()
                Text(AttributedStringsRepository
                    .errorAvatar
                    .attributed())
                    .padding(.init(
                        top: 8,
                        leading: 16,
                        bottom: 8,
                        trailing: 16
                    ))
                Spacer()
            }
        }
    }

    private struct WorkingView: View {
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(.init(
                            top: 8,
                            leading: 8,
                            bottom: 8,
                            trailing: 16
                        ))
                        .tint(Colors.chalk)
                }
                Spacer()
                Text(AttributedStringsRepository
                    .workingBio
                    .attributed())
                    .padding(.init(
                        top: 8,
                        leading: 16,
                        bottom: 8,
                        trailing: 16
                    ))
                Spacer()
            }
        }
    }

    struct BioView: View {
        let bio: ViewModel.Bio

        var body: some View {
            VStack {
                Spacer()
                Text(bio.summary)
                    .padding(16)
                Spacer()
            }
        }
    }
}

#if DEBUG

    import Swinject
    import SwinjectAutoregistration

    struct BioPageView_Previews: PreviewProvider {
        static var previews: some View {
            let resolver = AppResolver.preview

            BioPageView(viewModel: resolver~>)
        }
    }

#endif
