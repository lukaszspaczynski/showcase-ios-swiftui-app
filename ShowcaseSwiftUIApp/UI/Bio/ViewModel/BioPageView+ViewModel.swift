//
//  BioPageView+ViewModel.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 20/12/2021.
//

import Combine
import Foundation
import RxSwift
import ShowcaseDomain

extension BioPageView {
    final class ViewModel: ObservableObject {
        struct Bio {
            let summary: AttributedString
            let links: [(title: AttributedString, url: URL)]

            init(bio: GetBioUseCaseOutput) {
                summary = AttributedString(bio.bio)
                links = bio
                    .links
                    .map { (title: AttributedString($0.title), url: $0.url) }
            }
        }

        @Published private(set) var viewState: ViewState<Bio> = .working

        private let disposeBag = DisposeBag()
        private let getBioAction: GetBioUseCase.Output

        init(getBioUseCase: GetBioUseCase,
             avatarEndpoint _: AvatarEndpoint)
        {
            getBioAction = getBioUseCase
                .execute(())

            bind(getBioUseCase)
        }

        private func bind(_: GetBioUseCase) {
            getBioAction
                .elements
                .observe(on: MainScheduler.instance)
                .map(Bio.init)
                .subscribe { [weak self] result in

                    self?.viewState = .loaded(result)

                }.disposed(by: disposeBag)

            getBioAction
                .errors
                .observe(on: MainScheduler.instance)
                .subscribe { [weak self] error in

                    self?.viewState = .error(error)

                }.disposed(by: disposeBag)

            getBioAction
                .executing
                .filter { $0 }
                .observe(on: MainScheduler.instance)
                .subscribe { [weak self] _ in

                    self?.viewState = .working

                }.disposed(by: disposeBag)
        }

        func load(force: Bool = false) {
            switch (viewState, force) {
            case (.loaded, false):
                return
            default:
                getBioAction.execute()
            }
        }
    }
}
