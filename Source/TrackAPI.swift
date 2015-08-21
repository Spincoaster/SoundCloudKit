//
//  TrackAPI.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 8/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient {
    public func fetchTrack(trackId: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, Track?, NSError?) -> Void) -> Request {
        return manager.request(Router.Track(trackId)).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, Track(json: JSON(o)), error)
            }
        })
    }
}
