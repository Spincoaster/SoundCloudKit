//
//  APIClient.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON
import Alamofire

public protocol JSONInitializable {
    init(json: JSON)
}

public typealias RequestCallback = (NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void

public class APIClient {
    public typealias AccessToken = String

    public var manager: Alamofire.Manager!

    public static var clientId     = ""
    public static var baseURLString = "https://api.soundcloud.com"
    public static var accessToken: AccessToken?

    public class var isLoggedIn: Bool { return accessToken != nil }

    public init() {
        manager = Alamofire.Manager(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
    }

    public func fetch(route: Router, callback: RequestCallback) {
        self.manager.request(route).validate(statusCode: 200..<300).responseJSON(options: .allZeros) {(req: NSURLRequest, res: NSHTTPURLResponse?, obj: AnyObject?, error: NSError?) -> Void in
            callback(req, res, obj, error)
        }
    }

    public func fetchItem<T: JSONInitializable>(route: Router, callback: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) {
        manager
            .request(route)
            .validate(statusCode: 200..<300)
            .responseJSON(options: .allZeros) { req, res, obj, error in
                if let e = error {
                    callback(req, res, nil, e)
                } else {
                    callback(req, res, T(json: JSON(obj!)), error)
                }
        }
    }

    public func fetchItems<T: JSONInitializable>(route: Router, callback: (NSURLRequest, NSHTTPURLResponse?, [T]?, NSError?) -> Void) {
        manager
            .request(route)
            .validate(statusCode: 200..<300)
            .responseJSON(options: .allZeros) { req, res, obj, error in
                if let e = error {
                    callback(req, res, nil, e)
                } else {
                    callback(req, res, JSON(obj!).arrayValue.map { T(json: $0) }, error)
                }
        }
    }

    public enum Router: URLRequestConvertible {
        /* connect */
//        case Connect
        /* users */
        case Users(String)
        case User(String)
        case TracksOfUser(SoundCloudKit.User)
        case PlaylistsOfUser(SoundCloudKit.User)
        case FollowingsOfUser(SoundCloudKit.User)
//        case FollowersOfUser(SoundCloudKit.User)
//        case CommentsOfUser(SoundCloudKit.User)
        case FavoritesOfUser(SoundCloudKit.User)
//        case GroupsOfUser(SoundCloudKit.User)
//        case WebProfilesOfUser(SoundCloudKit.User)
        /* tracks */
        case Track(String)
//        case CommentsOfTrack(SoundCloudKit.Track)
//        case CommentOfTrack(SoundCloudKit.Track, SoundCloudKit.Comment)
//        case FavoritersOfTrack(SoundCloudKit.Track)
//        case FavoriterOfTrack(SoundCloudKit.Track, SoundCloudKit.User)
//        case SecretTokenOfTrack(SoundCloudKit.Track)
        /* playlists */
        case Playlist(String)
//        case SecretTokenOfPlaylist(SoundCloudKit.Playlist)
        /* groups */
        /* comments */
        /* me */
        case Me
        /* me/connections */
        /* me/activities */
        case Activities
        case NextActivities(String)
        case FutureActivities(String)
        /* apps */
        /* resolve */
        /* oembed */
        var method: Alamofire.Method {
            switch self {
            case Users:            return .GET
            case User:             return .GET
            case TracksOfUser:     return .GET
            case PlaylistsOfUser:  return .GET
            case FollowingsOfUser: return .GET
            case FavoritesOfUser:  return .GET
            case Track:            return .GET
            case Playlist:         return .GET
            case Me:               return .GET
            case Activities:       return .GET
            case NextActivities:   return .GET
            case FutureActivities: return .GET
            }
        }
        var path: String {
            switch self {
            case Users(let q):               return "/users"
            case User(let userId):           return "/users/\(userId)"
            case TracksOfUser(let user):     return "/users/\(user.id)/tracks"
            case PlaylistsOfUser(let user):  return "/users/\(user.id)/playlists"
            case FollowingsOfUser(let user): return "/users/\(user.id)/followings"
            case FavoritesOfUser(let user):  return "/users/\(user.id)/favorites"
            case Track(let trackId):         return "/tracks/\(trackId)"
            case Playlist(let playlistId):   return "/playlists/\(playlistId)"
            case Me:                         return "/me"
            case Activities:                 return "/me/activities"
            case NextActivities(let href):   return ""
            case FutureActivities(let href): return ""
            }
        }
        var url: NSURL {
            switch self {
            case NextActivities(let href):   return NSURL(string: href)!
            case FutureActivities(let href): return NSURL(string: href)!
            default:                         return NSURL(string: APIClient.baseURLString + path)!
            }
        }
        var params: [String: AnyObject] {
            switch self {
            case Users(let q):               return ["q": q]
            case User(let userId):           return [:]
            case TracksOfUser(let user):     return [:]
            case PlaylistsOfUser(let user):  return [:]
            case FollowingsOfUser(let user): return [:]
            case FavoritesOfUser(let user):  return [:]
            case Track(let trackId):         return [:]
            case Playlist(let playlistId):   return [:]
            case Me:                         return [:]
            case Activities:                 return [:]
            case NextActivities(let href):   return [:]
            case FutureActivities(let href): return [:]
            }
        }
        public var URLRequest: NSURLRequest {
            let U = Alamofire.ParameterEncoding.URL
            let req = NSMutableURLRequest(URL: url)
            req.HTTPMethod = method.rawValue
            var params = self.params
            params["client_id"] = clientId
            if let token = APIClient.accessToken {
                params["oauth_token"] = token
            }
            return U.encode(req, parameters: params).0
        }
    }
}