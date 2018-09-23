//
//  ViewController.swift
//  Localization
//
//  Created by Oleksii Huralnyk on 9/23/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var nextButton: UIButton?
    @IBOutlet private weak var gotItButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextButtonTitle = localizedString(Screens.Tooltips.Button.next)
        let gotItButtonTitle = NSLocalizedString("GOT IT!", comment: "Title of the last tooltip button")
        nextButton?.setTitle(nextButtonTitle, for: .normal)
        gotItButton?.setTitle(gotItButtonTitle, for: .normal)
    }
    
}

enum Screens {
    enum Tooltips {
        enum Button: String {
            case next = "NEXT"
            case gotIt = "GOT IT!"
        }
    }
}

func localizedString<K: RawRepresentable>(_ key: K) -> String where K.RawValue == String {
    return NSLocalizedString(key.rawValue, comment: "")
}


