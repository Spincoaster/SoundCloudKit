//
//  User.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON

class User {
    let id: Int
    let permalink:            String
    let username:             String
    let uri:                  String
    let permalinkUrl:         String
    let avatarUrl:            String
    let country:              String?
    let fullName:             String?
    let city:                 String?
    let description:          String?
    let discogsName:          String?
    let myspaceName:          String?
    let website:              String?
    let websiteTitle:         String?
    let online:               Bool?
    let trackCount:           Int?
    let playlistCount:        Int?
    let followersCount:       Int?
    let followingsCount:      Int?
    let publicFavoritesCount: Int?

    init(json: JSON) {
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
        websiteTitle         = json["website-title"].string
        online               = json["online"].bool
        trackCount           = json["track_count"].int
        playlistCount        = json["playlist_count"].int
        followersCount       = json["followers_count"].int
        followingsCount      = json["followings_count"].int
        publicFavoritesCount = json["public_favorites_count"].int
    }
}
