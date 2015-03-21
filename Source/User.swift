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
    let country:              String
    let fullName:             String
    let city:                 String
    let description:          String
    let discogsName:          String?
    let myspaceName:          String?
    let website:              String
    let websiteTitle:         String
    let online:               Bool
    let trackCount:           Int
    let playlistCount:        Int
    let followersCount:       Int
    let followingsCount:      Int
    let publicFavoritesCount: Int

    init(json: JSON) {
        id                   = json["id"].intValue
        permalink            = json["permalink"].stringValue
        username             = json["username"].stringValue
        uri                  = json["uri"].stringValue
        permalinkUrl         = json["permalink_url"].stringValue
        avatarUrl            = json["avatar_url"].stringValue
        country              = json["country"].stringValue
        fullName             = json["full_name"].stringValue
        city                 = json["city"].stringValue
        description          = json["description"].stringValue
        discogsName          = json["discogs-name"].string
        myspaceName          = json["myspace-name"].string
        website              = json["website"].stringValue
        websiteTitle         = json["website-title"].stringValue
        online               = json["online"].boolValue
        trackCount           = json["track_count"].intValue
        playlistCount        = json["playlist_count"].intValue
        followersCount       = json["followers_count"].intValue
        followingsCount      = json["followings_count"].intValue
        publicFavoritesCount = json["public_favorites_count"].intValue
    }
}
