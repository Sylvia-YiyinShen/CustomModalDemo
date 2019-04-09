//
//  ViewController.swift
//  CustomModalDemo
//
//  Created by Sylvia Shen on 4/3/19.
//  Copyright © 2019 Sylvia Shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func didTapOpen(_ sender: Any) {
         showMyModal()
    }
    private func showMyModal() {
        MyModalViewController().showAsPopover()
    }
}

