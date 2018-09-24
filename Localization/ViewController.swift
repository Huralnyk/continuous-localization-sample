//
//  ViewController.swift
//  Localization
//
//  Created by Oleksii Huralnyk on 9/23/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var nextButton: UIButton?
    
    var current = 0 {
        didSet {
            titleLabel?.text = L10n.Trainings.Label.numberOfCompleted(current, total)
            if current == total {
                nextButton?.setTitle(L10n.Tooltips.Button.gotIt, for: .normal)
            } else {
                nextButton?.setTitle(L10n.Tooltips.Button.next, for: .normal)
            }
        }
    }
    
    var total = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current = 1
    }
    
    @IBAction private func onButtonTap() {
        if current < total { current += 1 }
    }
    
}
