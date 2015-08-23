//
//  User.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON

public struct User: Hashable, Equatable, JSONInitializable {
    public let id: Int
    public let permalink:            String
    public let username:             String
    public let uri:                  String
    public let permalinkUrl:         String
    public let avatarUrl:            String
    public let country:              String?
    public let fullName:             String?
    public let city:                 String?
    public let description:          String?
    public let discogsName:          String?
    public let myspaceName:          String?
    public let website:              String?
    public let websiteTitle:         String?
    public let online:               Bool?
    public let trackCount:           Int?
    public let playlistCount:        Int?
    public let followersCount:       Int?
    public let followingsCount:      Int?
    public let publicFavoritesCount: Int?

    public var hashValue: Int {
        return id.hashValue
    }

    public init(json: JSON) {
        id                   = json["id"].intValue
        permalink            = json["permalink"].stringValue
        username             = json["username"].stringValue
        uri                  = json["uri"].stringValue
        permalinkUrl         = json["permalink_url"].stringValue
        avatarUrl            = json["avatar_url"].stringValue
        country              = json["country"].string
        fullName             = json["full_name"].string
        city                 = json["city"].string
        description          = json["description"].string
        discogsName          = json["discogs-name"].string
        myspaceName          = json["myspace-name"].string
        website              = json["website"].string
        websiteTitle         = json["website_title"].string
        online               = json["online"].bool
        trackCount           = json["track_count"].int
        playlistCount        = json["playlist_count"].int
        followersCount       = json["followers_count"].int
        followingsCount      = json["followings_count"].int
        publicFavoritesCount = json["public_favorites_count"].int
    }

    public func toJSON() -> JSON {
        var json                       = [:] as [String: AnyObject]
        json["id"]                     = id
        json["permalink"]              = permalink
        json["username"]               = username
        json["uri"]                    = uri
        json["permalink_url"]          = permalinkUrl
        json["avatar_url"]             = avatarUrl
        json["country"]                = country
        json["full_name"]              = fullName
        json["city"]                   = city
        json["description"]            = description
        json["discogs-name"]           = discogsName
        json["myspace-name"]           = myspaceName
        json["website"]                = website
        json["website_title"]          = websiteTitle
        json["online"]                 = online
        json["track_count"]            = trackCount
        json["playlist_count"]         = playlistCount
        json["followers_count"]        = followersCount
        json["followings_count"]       = followingsCount
        json["public_favorites_count"] = publicFavoritesCount
        return JSON(json)
    }
}

public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
}
