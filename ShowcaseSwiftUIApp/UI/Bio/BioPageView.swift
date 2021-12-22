//
//  BioPageView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 20/12/2021.
//

import SwiftUI

struct BioPageView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.openURL) private var openURL

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Group {
                switch viewModel.viewState {
                case let .error(error):
                    ErrorView(error: error) {
                        viewModel.load(force: true)
                    }
                case .working:
                    WorkingView()
                case let .loaded(bio):
                    BioView(bio: bio) { url in
                        openURL(url)
                    }
                }
            }
            Spacer()
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(AttributedStringsRepository
                        .prev
                        .attributed())
                        .padding(.init(
                            top: 8,
                            leading: 16,
                            bottom: 16,
                            trailing: 8
                        ))
                }
                Spacer()
                NavigationLink {
                    SkillsPageView()
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
        }
        .onAppear {
            viewModel.load()
        }
        .background(Colors.lightBlack)
        .navigationTitle("")
        .navigationBarHidden(true)
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
