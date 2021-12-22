//
//  BioPageView+BioView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 21/12/2021.
//

import Foundation
import SwiftUI

extension BioPageView {
    struct BioView: View {
        let bio: ViewModel.Bio
        let open: (URL) -> Void

        var body: some View {
            VStack(alignment: .leading) {
                Spacer()
                Text(bio.summary)
                    .padding(16)
                ForEach(bio.links, id: \.url) { link in
                    Button {
                        open(link.url)
                    } label: {
                        Text(link.title)
                            .padding(.init(
                                top: 0,
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

    import ShowcaseDomain
    import ShowcaseDomainMocks

    struct BioPageView_BioView_Previews: PreviewProvider {
        static var previews: some View {
            let bio = GetBioUseCaseOutputMockFactory.mock()
            let bioMock = BioPageView.ViewModel.Bio(bio: bio)

            BioPageView.BioView(bio: bioMock) { _ in
            }
            .background(Colors.lightBlack)
            .previewLayout(.sizeThatFits)
        }
    }

#endif
