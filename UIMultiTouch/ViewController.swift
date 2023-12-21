//
//  ViewController.swift
//  UIMultiTouch
//
//  Created by 63rabbits goodman on 2023/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let multiTouchableView = MultiTouchableView(frame: self.view.frame)
        self.view.addSubview(multiTouchableView)
        self.view.bringSubviewToFront(multiTouchableView)

        // for Debug
        print("Start!!")
    }


}
