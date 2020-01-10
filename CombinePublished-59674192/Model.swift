//
//  Model.swift
//  CombinePublished-59674192
//
//  Created by Mufakkharul Islam Nayem on 1/10/20.
//  Copyright © 2020 Mufakkharul Islam Nayem. All rights reserved.
//

import Combine

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper public struct EqPublished<Value: Equatable> {

    public var wrappedValue: Value
    {
        willSet {
            _projectedValue.send(newValue)
        }
    }
    public var projectedValue: AnyPublisher<Value, Never>
    private var _projectedValue: CurrentValueSubject<Value, Never>

    public init(wrappedValue: Value)
    {
        self.wrappedValue = wrappedValue
        self._projectedValue = CurrentValueSubject<Value, Never>(wrappedValue)
        self.projectedValue = _projectedValue.removeDuplicates().eraseToAnyPublisher()
    }
}

class Model: ObservableObject {
    @EqPublished var valueEq = 5
    @Published var valueAlways = 5

    private var storage = Set<AnyCancellable>()

    init() {
        $valueEq
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &storage)
    }

}
