//
//  ViewState.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 20/12/2021.
//

import Foundation

enum ViewState<Data> {
    case error(Error)
    case working
    case loaded(Data)
}
