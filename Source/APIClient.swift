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

public typealias RequestCallback = (URLRequest?, HTTPURLResponse?, Result<Any>) -> Void

open class APIClient {
    public typealias AccessToken = String

    open var manager: Alamofire.SessionManager

    open static var baseURLString = "https://api.soundcloud.com"
    open static var shared: APIClient = APIClient()

    open var clientId = ""
    open var accessToken: AccessToken?
    open var isLoggedIn: Bool { return accessToken != nil }

    public init() {
        manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.ephemeral)
    }

    open func fetch(_ route: Router, callback: @escaping RequestCallback) {
        self.manager.request(RouterRequest(router: route, client: self))
            .validate(statusCode: 200..<300).responseJSON(options: .allowFragments) { response in
            callback(response.request, response.response, response.result)
        }
    }

    open func fetchItem<T: JSONInitializable>(_ route: Router, callback: @escaping (URLRequest?, HTTPURLResponse?, Result<T>) -> Void) {
        manager
            .request(RouterRequest(router: route, client: self))
            .validate(statusCode: 200..<300)
            .responseJSON(options: .allowFragments) { response in
                if let e = response.result.error {
                    callback(response.request, response.response, Result.failure(e))
                } else {
                    callback(response.request, response.response, Result.success(T(json: JSON(response.result.value!))))
                }
        }
    }

    open func fetchItems<T: JSONInitializable>(_ route: Router, callback: @escaping (URLRequest?, HTTPURLResponse?, Result<[T]>) -> Void) {
        manager
            .request(RouterRequest(router: route, client: self))
            .validate(statusCode: 200..<300)
            .responseJSON(options: .allowFragments) { response in
                if let e = response.result.error {
                    callback(response.request, response.response, Result.failure(e))
                } else {
                    callback(response.request, response.response, Result.success(JSON(rawValue: response.result.value!)!.arrayValue.map { T(json: $0) }))
                }
        }
    }

    public enum Router {
        /* connect */
//        case Connect
        /* users */
        case users(String)
        case user(String)
        case tracksOfUser(SoundCloudKit.User)
        case playlistsOfUser(SoundCloudKit.User)
        case followingsOfUser(SoundCloudKit.User)
//        case FollowersOfUser(SoundCloudKit.User)
//        case CommentsOfUser(SoundCloudKit.User)
        case favoritesOfUser(SoundCloudKit.User)
//        case GroupsOfUser(SoundCloudKit.User)
//        case WebProfilesOfUser(SoundCloudKit.User)
        /* tracks */
        case track(String)
//        case CommentsOfTrack(SoundCloudKit.Track)
//        case CommentOfTrack(SoundCloudKit.Track, SoundCloudKit.Comment)
//        case FavoritersOfTrack(SoundCloudKit.Track)
//        case FavoriterOfTrack(SoundCloudKit.Track, SoundCloudKit.User)
//        case SecretTokenOfTrack(SoundCloudKit.Track)
        /* playlists */
        case playlist(String)
//        case SecretTokenOfPlaylist(SoundCloudKit.Playlist)
        /* groups */
        /* comments */
        /* me */
        case me
        /* me/connections */
        /* me/activities */
        case activities
        case nextActivities(String)
        case futureActivities(String)
        /* apps */
        /* resolve */
        /* oembed */
        var method: Alamofire.HTTPMethod {
            switch self {
            case .users:            return .get
            case .user:             return .get
            case .tracksOfUser:     return .get
            case .playlistsOfUser:  return .get
            case .followingsOfUser: return .get
            case .favoritesOfUser:  return .get
            case .track:            return .get
            case .playlist:         return .get
            case .me:               return .get
            case .activities:       return .get
            case .nextActivities:   return .get
            case .futureActivities: return .get
            }
        }
        var path: String {
            switch self {
            case .users(_):                   return "/users"
            case .user(let userId):           return "/users/\(userId)"
            case .tracksOfUser(let user):     return "/users/\(user.id)/tracks"
            case .playlistsOfUser(let user):  return "/users/\(user.id)/playlists"
            case .followingsOfUser(let user): return "/users/\(user.id)/followings"
            case .favoritesOfUser(let user):  return "/users/\(user.id)/favorites"
            case .track(let trackId):         return "/tracks/\(trackId)"
            case .playlist(let playlistId):   return "/playlists/\(playlistId)"
            case .me:                         return "/me"
            case .activities:                 return "/me/activities"
            case .nextActivities(_):          return ""
            case .futureActivities(_):        return ""
            }
        }
        var url: URL {
            switch self {
            case .nextActivities(let href):   return URL(string: href)!
            case .futureActivities(let href): return URL(string: href)!
            default:                         return URL(string: APIClient.baseURLString + path)!
            }
        }
        var params: [String: AnyObject] {
            switch self {
            case .users(let q):        return ["q": q as AnyObject]
            case .user(_):             return [:]
            case .tracksOfUser(_):     return [:]
            case .playlistsOfUser(_):  return [:]
            case .followingsOfUser(_): return [:]
            case .favoritesOfUser(_):  return [:]
            case .track(_):            return [:]
            case .playlist(_):         return [:]
            case .me:                  return [:]
            case .activities:          return [:]
            case .nextActivities(_):   return [:]
            case .futureActivities(_): return [:]
            }
        }
        var needsOAuthToken: Bool {
            switch self {
            case .users(_):            return false
            case .user(_):             return false
            case .tracksOfUser(_):     return false
            case .playlistsOfUser(_):  return false
            case .followingsOfUser(_): return false
            case .favoritesOfUser(_):  return false
            case .track(_):            return false
            case .playlist(_):         return false
            case .me:                  return true
            case .activities:          return true
            case .nextActivities(_):   return true
            case .futureActivities(_): return true
            }
        }
    }
}

internal struct RouterRequest: URLRequestConvertible {
    var router: APIClient.Router
    var client: APIClient
    public func asURLRequest() throws -> URLRequest {
        var req = URLRequest(url: router.url)
        req.httpMethod = router.method.rawValue
        var params = router.params
        params["client_id"] = client.clientId as AnyObject?
        if let token = client.accessToken, router.needsOAuthToken {
            params["oauth_token"] = token as AnyObject?
        }
        return try URLEncoding.default.encode(req, with: params)
    }
}
