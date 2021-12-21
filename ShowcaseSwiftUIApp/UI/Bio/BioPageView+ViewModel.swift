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

            init(bio: GetBioUseCaseOutput) {
                summary = AttributedString(bio.bio)
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

        func load() {
            getBioAction.execute()
        }
    }
}
