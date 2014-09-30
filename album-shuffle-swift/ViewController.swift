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

    var albums : [Dictionary<NSObject, NSObject>]?

    var currentAlbumIndex = 0

    var signInButton : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let accessToken = Settings.rdioAccessToken {
            rdio.authorizeUsingAccessToken(accessToken)
        } else {
            let button = UIButton.buttonWithType(.System) as UIButton
            button.setTitle("Sign in", forState: .Normal)
            button.sizeToFit()
            button.origin = CGPoint(x: 20, y: 100)
            button.addTarget(self, action: "signInTapped:", forControlEvents: .TouchUpInside)
            self.view.addSubview(button)
            signInButton = button
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    func signInTapped(sender: AnyObject) {
        rdio.authorizeFromController(self)
    }

    func requestCollectionAlbums() {
        var delegate = RdioAPIDelegate(successBlock:{request, responseData in
            println("Got results")
            let albums = responseData as Array<Dictionary<NSObject, NSObject>>
            println("Number of albums in response: \(albums.count)")
            let streamableAlbums = filter(albums, { album in (album["canStream"] as NSNumber).boolValue })
            println("Streamable albums: \(streamableAlbums.count)")
            self.albums = streamableAlbums
            self.startPlayback()
        },
        errorBlock:{request, error in
            println("Got error \(error.description)")
        })
        rdio.callAPIMethod("getAlbumsInCollection", withParameters: ["extras": "-*,key,canStream"], delegate:delegate)
    }

    func shuffleAlbums() {
        var albums = self.albums!
        for var j = albums.count-1; j > 0; j-- {
            let i = Int(arc4random_uniform(UInt32(j)))
            let tmp = albums[i]
            albums[i] = albums[j]
            albums[j] = tmp
        }
        self.albums = albums
    }

    func playAlbumAtIndex(index : Int) {
        if let album = self.albums?[index] {
            self.currentAlbumIndex = index
            let key = album["key"] as NSString
            println("Playing album with key \(key)")
            self.rdio.player.playSource(key)
        }
    }

    func startPlayback() {
        shuffleAlbums()
        self.rdio.preparePlayerWithDelegate(nil)
        playAlbumAtIndex(0)
    }

    // MARK: - RdioDelegate

    func rdioDidAuthorizeUser(user: [NSObject : AnyObject]!, withAccessToken accessToken: String!) {
        signInButton?.removeFromSuperview()
        let userKey = user["key"]! as String
        println("User \(userKey) signed in")
        Settings.rdioAccessToken = accessToken
        requestCollectionAlbums()
    }

}

