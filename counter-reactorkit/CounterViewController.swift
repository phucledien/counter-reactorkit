//
//  CounterViewController.swift
//  counter-reactorkit
//
//  Created by Phuc Le Dien on 8/16/19.
//  Copyright © 2019 Dwarves Foundation. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class CounterViewController: UIViewController, StoryboardView {
    
    @IBOutlet weak var btnDecrease: UIButton!
    @IBOutlet weak var btnIncrease: UIButton!
    
    @IBOutlet weak var lblValue: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: CounterReactorView) {
        // Action
        btnIncrease.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        btnDecrease.rx.tap
        .map { Reactor.Action.decrease }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: lblValue.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
}
