//
//  PlaylistAPI.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 8/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient {
    public func fetchPlaylist(playlistId: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, Playlist?, NSError?) -> Void) -> Request {
        return manager.request(Router.Track(playlistId)).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, Playlist(json: JSON(o)), error)
            }
        })
    }
}
