//
//  BioPageView+ErrorView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 21/12/2021.
//

import Foundation
import SwiftUI

extension BioPageView {
    struct ErrorView: View {
        let error: Error
        let reload: () -> Void

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
                HStack {
                    Spacer()
                    Button {
                        reload()
                    } label: {
                        Text(AttributedStringsRepository
                            .reload
                            .attributed())
                            .padding(.init(
                                top: 8,
                                leading: 16,
                                bottom: 8,
                                trailing: 16
                            ))
                    }
                }
                Spacer()
            }
        }
    }
}

#if DEBUG

    struct BioPageView_ErrorView_Previews: PreviewProvider {
        enum DummyError: Error {
            case dummy
        }

        static var previews: some View {
            BioPageView.ErrorView(error: DummyError.dummy) {}
                .background(Colors.lightBlack)
                .previewLayout(.sizeThatFits)
        }
    }

#endif
