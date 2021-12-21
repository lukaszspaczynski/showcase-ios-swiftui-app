//
//  AnimationTimer.swift
//  ShowcaseSwiftUIApp
//
//  Created by Lukasz Spaczynski on 20/12/2021.
//

import Combine
import Foundation

class AnimationTimer {
    let step: Double

    var tick: AnyPublisher<Date, Never> {
        tickSubject
            .eraseToAnyPublisher()
    }

    private var timerCancellable: Cancellable?
    private let tickSubject: PassthroughSubject<Date, Never> = .init()

    init(step: Double) {
        self.step = step
    }

    func start() {
        timerCancellable = Timer
            .publish(every: step, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: { [unowned self] in self.tickSubject.send($0) })
    }

    func cancel() {
        timerCancellable?.cancel()
    }
}
