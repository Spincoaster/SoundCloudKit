//
//  APIClient.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON
import Alamofire

struct APIClientConfig{
    var client_id: String?
}

public class APIClient {
    public typealias AccessToken = String

    public struct Config {
        public static var accessToken: AccessToken?
    }

    public class var baseURLString: String       { return "http://soundcloud.com" }
    public class var accessToken:   AccessToken? { return Config.accessToken }

    public enum Router: URLRequestConvertible {
        case Connect
        case OAuth2Token
        case Users
        case Tracks
        case Playlists
        case Groups
        case Comments
        case Me
        case Connections
        case Activities
        case Apps
        case Resolve
        case OEmbed
        var method: Alamofire.Method {
            switch self {
            case Connect:     return .GET
            case OAuth2Token: return .GET
            case Users:       return .GET
            case Tracks:      return .GET
            case Playlists:   return .GET
            case Groups:      return .GET
            case Comments:    return .GET
            case Me:          return .GET
            case Connections: return .GET
            case Activities:  return .GET
            case Apps:        return .GET
            case Resolve:     return .GET
            case OEmbed:      return .GET
            }
        }
        var path: String {
            switch self {
            case Connect:     return "/connect"
            case OAuth2Token: return "/oauth2/token"
            case Users:       return "/users/"
            case Tracks:      return "/tracks"
            case Playlists:   return "/playlists"
            case Groups:      return "/groups"
            case Comments:    return "/comments"
            case Me:          return "/me"
            case Connections: return "/me/connections"
            case Activities:  return "/me/activities"
            case Apps:        return "/apps"
            case Resolve:     return "/resolve"
            case OEmbed:      return "/oembed"
            }
        }
        public var URLRequest: NSURLRequest {
            let J = Alamofire.ParameterEncoding.JSON
            let URL = NSURL(string: APIClient.baseURLString + path)!
            let req = NSMutableURLRequest(URL: URL)

            req.HTTPMethod = method.rawValue

            if let token = APIClient.accessToken {
                req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }

            switch self {
            case Connect:     return req
            case OAuth2Token: return req
            case Users:       return req
            case Tracks:      return req
            case Playlists:   return req
            case Groups:      return req
            case Comments:    return req
            case Me:          return req
            case Connections: return req
            case Activities:  return req
            case Apps:        return req
            case Resolve:     return req
            case OEmbed:      return req
            }
        }
    }
}