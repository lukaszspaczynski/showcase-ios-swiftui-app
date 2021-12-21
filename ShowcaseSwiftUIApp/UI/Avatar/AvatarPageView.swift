//
//  AvatarPageView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

import Combine
import RxSwift
import SwiftUI

struct AvatarPageView: View {
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
                    ErrorView(error: error)
                case .working:
                    WorkingView()
                case let .loaded(avatar):
                    AvatarView(avatar: avatar)
                }
            }
            Spacer()
            HStack {
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

extension AvatarPageView {
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
                    .workingAvatar
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

    struct AvatarView: View {
        @State private var index = 0

        private let timer = AnimationTimer(step: 0.33)
        let avatar: ViewModel.Avatar

        private var avatarImage: UIImage {
            if avatar.pixelized.count > index {
                return avatar.pixelized[index]
            } else {
                return avatar.avatar
            }
        }

        var body: some View {
            Image(uiImage: avatarImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(16)
                .onReceive(timer.tick, perform: nextImage())
                .onAppear { timer.start() }
                .onDisappear { timer.cancel() }
                .onTapGesture(perform: restartImageAnimation())
        }

        private func nextImage() -> ((Date) -> Void) {
            return { (_: Date) in
                if index < avatar.pixelized.count {
                    index += 1
                } else {
                    timer.cancel()
                }
            }
        }

        private func restartImageAnimation() -> (() -> Void) {
            return {
                timer.cancel()
                index = 0
                timer.start()
            }
        }
    }
}

#if DEBUG

    import Swinject
    import SwinjectAutoregistration

    struct AvatarPageView_Previews: PreviewProvider {
        static var previews: some View {
            let resolver = AppResolver.preview

            AvatarPageView(viewModel: resolver~>)
        }
    }

#endif
