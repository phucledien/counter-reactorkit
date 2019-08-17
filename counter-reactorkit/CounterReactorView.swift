//
//  CounterReactorView.swift
//  counter-reactorkit
//
//  Created by Phuc Le Dien on 8/16/19.
//  Copyright © 2019 Dwarves Foundation. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class CounterReactorView: Reactor {
    
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State {
        var value: Int
        var isLoading: Bool
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            value: 0,
            isLoading: false
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase: return Observable.concat([
            Observable.just(.setLoading(true)),
            Observable.just(.increaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
            Observable.just(.setLoading(false))
        ])
        case .decrease: return Observable.concat([
            Observable.just(.setLoading(true)),
            Observable.just(.decreaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
            Observable.just(.setLoading(false))
        ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
}
