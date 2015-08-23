//
//  Playlist.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/22/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON

public enum PlaylistType: String {
    case EPSingle     = "ep single"
    case Album        = "album"
    case Compilation  = "compilation"
    case ProjectFiles = "project files"
    case Archive      = "archive"
    case Showcase     = "showcase"
    case Demo         = "demo"
    case SamplePack   = "sample pack"
    case Other        = "other"
}

public struct Playlist: Hashable, Equatable {
    public let id:           Int
    public let createdAt:    String
    public let userId:       Int
    public let user:         User
    public let title:        String
    public let permalink:    String
    public let permalinkUrl: String
    public let uri:          String
    public let sharing:      Sharing
    public let embeddableBy: EmbeddableBy?
    public let purchaseUrl:  String?
    public let artworkUrl:   String?
    public let description:  String?
    public let label:        User
    public let duration:     Int64
    public let genre:        String?
    public let tagList:      String
    public let labelId:      Int64?
    public let labelName:    String?
    public let release:      Int?
    public let releaseDay:   Int?
    public let releaseMonth: Int?
    public let releaseYear:  Int?
    public let streamable:   Bool
    public let downloadable: Bool
    public let ean:          String
    public let playlistType: PlaylistType?
    public let tracks:       [Track]
    public let trackCount:   Int

    public var hashValue: Int {
        return id.hashValue
    }

    public init(json: JSON) {
        id                  = json["id"].intValue
        createdAt           = json["created_at"].stringValue
        userId              = json["user_id"].intValue
        user                = User(json: json["user"])
        title               = json["title"].stringValue
        permalink           = json["permalink"].stringValue
        permalinkUrl        = json["permalink_url"].stringValue
        uri                 = json["uri"].stringValue
        sharing             = Sharing(rawValue: json["sharing"].stringValue)!
        embeddableBy        = EmbeddableBy(rawValue: json["embeddable_by"].stringValue)
        purchaseUrl         = json["purchase_url"].string
        artworkUrl          = json["artwork_url"].string
        description         = json["description"].string
        label               = User(json: json["label"])
        duration            = json["duration"].int64Value
        genre               = json["genre"].string
        tagList             = json["tag_list"].stringValue
        labelId             = json["label_id"].int64
        labelName           = json["label_name"].string
        release             = json["release"].int
        releaseDay          = json["release_day"].int
        releaseMonth        = json["release_month"].int
        releaseYear         = json["release_year"].int
        streamable          = json["streamable"].boolValue
        downloadable        = json["downloadable"].boolValue
        ean                 = json["ean"].stringValue
        playlistType        = PlaylistType(rawValue: json["playlist_type"].stringValue)
        tracks              = json["tracks"].arrayValue.map({ Track(json: $0) })
        trackCount          = json["track_count"].intValue
    }
}

public func ==(lhs: Playlist, rhs: Playlist) -> Bool {
    return lhs.id == rhs.id
}
