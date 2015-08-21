//
//  UserAPI.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 8/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient {
    public func fetchUser(userId: String, completionHandler: (NSURLRequest, NSHTTPURLResponse?, User?, NSError?) -> Void) -> Request {
        return manager.request(Router.User(userId)).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, User(json: JSON(o)), error)
            }
        })
    }

    public func fetchMe(completionHandler: (NSURLRequest, NSHTTPURLResponse?, User?, NSError?) -> Void) -> Request {
        return manager.request(Router.Me).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, User(json: JSON(o)), error)
            }
        })
    }

    public func fetchTracksOf(user: User, completionHandler: (NSURLRequest, NSHTTPURLResponse?, [Track]?, NSError?) -> Void) -> Request {
        return manager.request(Router.TracksOfUser(user)).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, JSON(o).arrayValue.map { Track(json: $0) }, error)
            }
        })
    }

    public func fetchPlaylistsOf(user: User, completionHandler: (NSURLRequest, NSHTTPURLResponse?, [Playlist]?, NSError?) -> Void) -> Request {
        return manager.request(Router.PlaylistsOfUser(user)).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, JSON(o).arrayValue.map { Playlist(json: $0) }, error)
            }
        })
    }

    public func fetchFollowingsOf(user: User, completionHandler: (NSURLRequest, NSHTTPURLResponse?, [User]?, NSError?) -> Void) -> Request {
        return manager.request(Router.FollowingsOfUser(user)).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, JSON(o).arrayValue.map { User(json: $0) }, error)
            }
        })
    }

    public func fetchFollowingsOf(user: User, completionHandler: (NSURLRequest, NSHTTPURLResponse?, [Track]?, NSError?) -> Void) -> Request {
        return manager.request(Router.FavoritesOfUser(user)).validate().responseJSON(options: .allZeros, completionHandler: { (req, res, obj, error) -> Void in
            if let e = error {
                completionHandler(req, res, nil, e)
            } else if let o: AnyObject = obj {
                completionHandler(req, res, JSON(o).arrayValue.map { Track(json: $0) }, error)
            }
        })
    }
    
}
