//
//  RdioAPIDelegate.swift
//  album-shuffle-swift
//
//  Created by Eric Fikus on 9/16/14.
//  Copyright (c) 2014 Eric Fikus. All rights reserved.
//

import Foundation

class RdioAPIDelegate : RDAPIRequestDelegate
{
    typealias SuccessBlock = (RDAPIRequest!, AnyObject!) -> ()
    typealias ErrorBlock = (RDAPIRequest!, NSError!) -> ()

    var successBlock : SuccessBlock?
    var errorBlock : ErrorBlock?

    init(successBlock: SuccessBlock?, errorBlock: ErrorBlock?) {
        super.init(target: self, loadedAction: "loaded:responseData:", failedAction: "failed:error:")
        self.successBlock = successBlock
        self.errorBlock = errorBlock
    }

    override init() {
        super.init()
    }

    func loaded(request: RDAPIRequest, responseData: AnyObject) {
        successBlock?(request, responseData)
    }

    func failed(request: RDAPIRequest, error: NSError) {
        errorBlock?(request, error)
    }
}