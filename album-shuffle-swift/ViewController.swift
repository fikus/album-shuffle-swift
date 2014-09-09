//
//  ViewController.swift
//  album-shuffle-swift
//
//  Created by Eric Fikus on 9/9/14.
//  Copyright (c) 2014 Eric Fikus. All rights reserved.
//

import UIKit

class ViewController : UIViewController, RdioDelegate {

    lazy var rdio : Rdio = Rdio(consumerKey: RdioConsumerKey, andSecret: RdioSecret, delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rdio.authorizeFromController(self)
    }
}

