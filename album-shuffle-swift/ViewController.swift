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

        if let accessToken = Settings.rdioAccessToken {
            rdio.authorizeUsingAccessToken(accessToken)
        } else {
            let button = UIButton.buttonWithType(.System) as UIButton
            button.setTitle("Sign in", forState: .Normal)
            button.sizeToFit()
            button.origin = CGPoint(x: 20, y: 100)
            button.addTarget(self, action: Selector("signInTapped:"), forControlEvents: .TouchUpInside)
            self.view.addSubview(button)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    func signInTapped(sender: AnyObject) {
        rdio.authorizeFromController(self)
    }

    func rdioDidAuthorizeUser(user: [NSObject : AnyObject]!, withAccessToken accessToken: String!) {
        let userKey = user["key"]! as String
        println("User \(userKey) signed in")
        Settings.rdioAccessToken = accessToken
        requestCollectionAlbums()
    }

    func requestCollectionAlbums() {
        var delegate = RdioAPIDelegate(successBlock:{request, responseData in
            println("Got results")
            let albums = responseData as Array<Dictionary<String, NSObject>>
            println("Number of albums in response: \(albums.count)")
        },
        errorBlock:{request, error in
            println("Got error \(error.description)")
        })
        rdio.callAPIMethod("getAlbumsInCollection", withParameters: ["extras": "-*,key"], delegate:delegate)
    }

}

