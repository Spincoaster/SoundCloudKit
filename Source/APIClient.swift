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

public typealias RequestCallback = (NSURLRequest?, NSHTTPURLResponse?, Result<AnyObject>) -> Void

public class APIClient {
    public typealias AccessToken = String

    public var manager: Alamofire.Manager!

    public static var clientId     = ""
    public static var baseURLString = "https://api.soundcloud.com"
    public static var accessToken: AccessToken?
    public static var sharedInstance: APIClient = APIClient()

    public class var isLoggedIn: Bool { return accessToken != nil }

    public init() {
        manager = Alamofire.Manager(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
    }

    public func fetch(route: Router, callback: RequestCallback) {
        self.manager.request(route).validate(statusCode: 200..<300).responseJSON(options: .AllowFragments) {(req: NSURLRequest?, res: NSHTTPURLResponse?, result: Result<AnyObject>) -> Void in
            callback(req, res, result)
        }
    }

    public func fetchItem<T: JSONInitializable>(route: Router, callback: (NSURLRequest?, NSHTTPURLResponse?, Result<T>) -> Void) {
        manager
            .request(route)
            .validate(statusCode: 200..<300)
            .responseJSON(options: .AllowFragments) { req, res, result in
                if let e = result.error {
                    callback(req, res, Result.Failure(result.data, e))
                } else {
                    callback(req, res, Result.Success(T(json: JSON(result.value!))))
                }
        }
    }

    public func fetchItems<T: JSONInitializable>(route: Router, callback: (NSURLRequest?, NSHTTPURLResponse?, Result<[T]>) -> Void) {
        manager
            .request(route)
            .validate(statusCode: 200..<300)
            .responseJSON(options: .AllowFragments) { req, res, result in
                if let e = result.error {
                    callback(req, res, Result.Failure(result.data, e))
                } else {
                    callback(req, res, Result.Success(JSON(rawValue: result.value!)!.arrayValue.map { T(json: $0) }))
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
            case Users(_):                   return "/users"
            case User(let userId):           return "/users/\(userId)"
            case TracksOfUser(let user):     return "/users/\(user.id)/tracks"
            case PlaylistsOfUser(let user):  return "/users/\(user.id)/playlists"
            case FollowingsOfUser(let user): return "/users/\(user.id)/followings"
            case FavoritesOfUser(let user):  return "/users/\(user.id)/favorites"
            case Track(let trackId):         return "/tracks/\(trackId)"
            case Playlist(let playlistId):   return "/playlists/\(playlistId)"
            case Me:                         return "/me"
            case Activities:                 return "/me/activities"
            case NextActivities(_):          return ""
            case FutureActivities(_):        return ""
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
            case Users(let q):        return ["q": q]
            case User(_):             return [:]
            case TracksOfUser(_):     return [:]
            case PlaylistsOfUser(_):  return [:]
            case FollowingsOfUser(_): return [:]
            case FavoritesOfUser(_):  return [:]
            case Track(_):            return [:]
            case Playlist(_):         return [:]
            case Me:                  return [:]
            case Activities:          return [:]
            case NextActivities(_):   return [:]
            case FutureActivities(_): return [:]
            }
        }
        var needsOAuthToken: Bool {
            switch self {
            case Users(_):            return false
            case User(_):             return false
            case TracksOfUser(_):     return false
            case PlaylistsOfUser(_):  return false
            case FollowingsOfUser(_): return false
            case FavoritesOfUser(_):  return false
            case Track(_):            return false
            case Playlist(_):         return false
            case Me:                  return true
            case Activities:          return true
            case NextActivities(_):   return true
            case FutureActivities(_): return true
            }
        }
        public var URLRequest: NSMutableURLRequest {
            let U = Alamofire.ParameterEncoding.URL
            let req = NSMutableURLRequest(URL: url)
            req.HTTPMethod = method.rawValue
            var params = self.params
            params["client_id"] = clientId
            if let token = APIClient.accessToken where self.needsOAuthToken {
                params["oauth_token"] = token
            }
            return U.encode(req, parameters: params).0
        }
    }
}