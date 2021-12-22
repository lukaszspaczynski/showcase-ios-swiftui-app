//
//  AvatarPageView+AvatarView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 21/12/2021.
//

import Foundation
import SwiftUI

extension AvatarPageView {
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

    import ShowcaseDomain
    import ShowcaseDomainMocks

    struct AvatarPageView_AvatarView_Previews: PreviewProvider {
        static var previews: some View {
            let avatar = GetAvatarUseCaseOutputMockFactory.mock()

            AvatarPageView.AvatarView(avatar: avatar)
                .background(Colors.lightBlack)
                .previewLayout(.sizeThatFits)
        }
    }

#endif
