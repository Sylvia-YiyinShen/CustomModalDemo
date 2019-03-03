//
//  MyModalViewController.swift
//  CustomModalDemo
//
//  Created by Zhihui Sun on 4/3/19.
//  Copyright © 2019 Sylvia Shen. All rights reserved.
//

import UIKit

class MyModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func didTapCloseButton(_ sender: Any) {
        dismissAsPopover()
    }
}

extension MyModalViewController: PoppableProtocol {
    var modalSize: CGSize {
        return CGSize(width: 300, height: 200)
    }
}
