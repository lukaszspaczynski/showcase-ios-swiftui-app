//
//  AvatarPageViewModel.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 17/12/2021.
//

import Combine
import Foundation
import RxSwift
import ShowcaseDomain

extension AvatarPageView {
    final class ViewModel: ObservableObject {
        typealias Avatar = GetAvatarUseCaseOutput

        @Published private(set) var viewState: ViewState<Avatar> = .working

        private let disposeBag = DisposeBag()
        private let getAvatarAction: GetAvatarUseCase.Output

        init(getAvatarUseCase: GetAvatarUseCase,
             avatarEndpoint: AvatarEndpoint)
        {
            getAvatarAction = getAvatarUseCase
                .execute(avatarEndpoint.avatarEndpoint)

            bind(getAvatarUseCase)
        }

        private func bind(_: GetAvatarUseCase) {
            getAvatarAction
                .elements
                .observe(on: MainScheduler.instance)
                .subscribe { [weak self] result in

                    self?.viewState = .loaded(result)

                }.disposed(by: disposeBag)

            getAvatarAction
                .errors
                .observe(on: MainScheduler.instance)
                .subscribe { [weak self] error in

                    self?.viewState = .error(error)

                }.disposed(by: disposeBag)

            getAvatarAction
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
                getAvatarAction.execute()
            }
        }
    }
}
