//
//  BioPageView+WorkingView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 21/12/2021.
//

import Foundation
import SwiftUI

extension BioPageView {
    struct WorkingView: View {
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
}

#if DEBUG

    struct BioPageView_WorkingView_Previews: PreviewProvider {
        static var previews: some View {
            BioPageView.WorkingView()
                .background(Colors.lightBlack)
                .previewLayout(.sizeThatFits)
        }
    }

#endif
