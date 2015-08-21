//
//  APIClient.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON
import Alamofire

struct APIClientConfig {
    static var clientId: String?
}

@objc public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}

@objc public protocol ResponseCollectionSerializable {
    static func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, T?, NSError?) -> Void) -> Self {
        let serializer: Serializer = { (request, response, data) in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
            if response != nil && JSON != nil {
                return (T(response: response!, representation: JSON!), nil)
            } else {
                return (nil, serializationError)
            }
        }
        
        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? T, error)
        })
    }
    
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: (NSURLRequest, NSHTTPURLResponse?, [T]?, NSError?) -> Void) -> Self {
        let serializer: Serializer = { (request, response, data) in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
            if response != nil && JSON != nil {
                return (T.collection(response: response!, representation: JSON!), nil)
            } else {
                return (nil, serializationError)
            }
        }
        
        return response(serializer: serializer, completionHandler: { (request, response, object, error) in
            completionHandler(request, response, object as? [T], error)
        })
    }
}

public class APIClient {
    public typealias AccessToken = String

    public var manager: Alamofire.Manager!

    public struct Config {
        public static var accessToken: AccessToken?
    }

    public class var baseURLString: String       { return "http://soundcloud.com" }
    public class var accessToken:   AccessToken? { return Config.accessToken }

    public init() {
        manager = Alamofire.Manager(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
    }

    public enum Router: URLRequestConvertible {
        /* connect */
//        case Connect
        /* users */
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
        /* apps */
        /* resolve */
        /* oembed */
        var method: Alamofire.Method {
            switch self {
            case User:             return .GET
            case TracksOfUser:     return .GET
            case PlaylistsOfUser:  return .GET
            case FollowingsOfUser: return .GET
            case FavoritesOfUser:  return .GET
            case Track:            return .GET
            case Playlist:         return .GET
            case Me:               return .GET
            }
        }
        var path: String {
            switch self {
            case User(let userId):           return "/users/\(userId)"
            case TracksOfUser(let user):     return "/users/\(user.id)/tracks"
            case PlaylistsOfUser(let user):  return "/users/\(user.id)/playlists"
            case FollowingsOfUser(let user): return "/users/\(user.id)/followings"
            case FavoritesOfUser(let user):  return "/users/\(user.id)/favorites"
            case Track(let trackId):         return "/tracks/\(trackId)"
            case Playlist(let playlistId):   return "/playlists/\(playlistId)"
            case Me:                         return "/me"
            }
        }
        public var URLRequest: NSURLRequest {
            let J = Alamofire.ParameterEncoding.JSON
            let U = Alamofire.ParameterEncoding.URL
            let URL = NSURL(string: APIClient.baseURLString + path)!
            var req: NSURLRequest
            let _req = NSMutableURLRequest(URL: URL)

            _req.HTTPMethod = method.rawValue

            if let token = APIClient.accessToken {
                _req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            if let clientId = APIClientConfig.clientId {
               req = U.encode(_req, parameters: ["client_id": clientId]).0
            } else {
               req = _req
            }
            switch self {
            case User:             return req
            case TracksOfUser:     return req
            case PlaylistsOfUser:  return req
            case FollowingsOfUser: return req
            case FavoritesOfUser:  return req
            case Track:            return req
            case Playlist:         return req
            case Me:               return req
            }
        }
    }
}