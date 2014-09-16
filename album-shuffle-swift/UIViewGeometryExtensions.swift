//
//  UIViewGeometryExtensions.swift
//  album-shuffle-swift
//
//  Created by Eric Fikus on 9/16/14.
//  Copyright (c) 2014 Eric Fikus. All rights reserved.
//

import Foundation

extension UIView {

    var top : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    var left : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    var origin : CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
}