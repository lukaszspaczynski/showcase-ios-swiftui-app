//
//  SkillsPageView.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 21/12/2021.
//

import SwiftUI

struct SkillsPageView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack {
            Spacer()
            Text(AttributedStringsRepository
                .skills
                .attributed())
                .padding(16)
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
            }
        }
        .background(Colors.lightBlack)
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

#if DEBUG

    struct SkillsPageView_Previews: PreviewProvider {
        static var previews: some View {
            SkillsPageView()
        }
    }

#endif
