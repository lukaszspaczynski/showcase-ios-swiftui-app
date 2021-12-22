//
//  AttributedStringsRepository.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 21/12/2021.
//

import Foundation
import SwiftUI

enum AttributedStringsRepository {
    case welcome
    case workingBio
    case workingAvatar
    case prev
    case next
    case errorBio
    case errorAvatar
    case skills
    case reload

    func attributed() -> AttributedString {
        switch self {
        case .welcome:
            return AttributedString(load(name: "welcome"))
        case .workingBio:
            return AttributedString(load(name: "working_bio"))
        case .workingAvatar:
            return AttributedString(load(name: "working_avatar"))
        case .prev:
            return AttributedString(load(name: "prev"))
        case .next:
            return AttributedString(load(name: "next"))
        case .errorBio:
            return AttributedString(load(name: "error_bio"))
        case .errorAvatar:
            return AttributedString(load(name: "error_avatar"))
        case .skills:
            return AttributedString(load(name: "skills"))
        case .reload:
            return AttributedString(load(name: "reload"))
        }
    }

    private func load(name: String) -> NSAttributedString {
        guard let url = Bundle.main.url(forResource: name, withExtension: "rtf"),
              let attr = try? NSAttributedString.rtf(url: url)
        else {
            return NSAttributedString(string: "")
        }

        return attr
    }
}
