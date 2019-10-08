//
//  Loading.swift
//  
//
//  Created by Avario Babushka on 8/10/19.
//

import Combine

public extension Publisher {

    func loading<Root>(into keyPath: ReferenceWritableKeyPath<Root, Bool>, on object: Root) -> AnyPublisher<Self.Output, Self.Failure> {

        return self.handleEvents(
            receiveSubscription: { _ in object[keyPath: keyPath] = true},
            receiveCompletion: { _ in object[keyPath: keyPath] = false},
            receiveCancel: { object[keyPath: keyPath] = false})
            .eraseToAnyPublisher()
    }

}
