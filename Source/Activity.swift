//
//  Activity.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 8/26/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ActivityList: JSONInitializable {
    public var nextHref:   String?
    public var futureHref: String?
    public var collection: [Activity]
    public init(json: JSON) {
        nextHref   = json["next_href"].string
        futureHref = json["future_href"].string
        collection = json["collection"].arrayValue
            .filter { ActivityType(rawValue: $0["type"].stringValue) != nil }
            .map { Activity(json: $0) }
    }
}

public enum ActivityType: String {
    case Track          = "track"
    case TrackRepost    = "track-repost"
    case TrackSharing   = "track-sharing"
    case Comment        = "comment"
    case Favoriting     = "favoriting"
    case Playlist       = "playlist"
    case PlaylistRepost = "playlist-repost"
}

public struct Activity: JSONInitializable  {
    public enum TagType: String {
        case Exclusive    = "exclusive"
        case Affiliated   = "affiliated"
        case First        = "first"
        case Own          = "own"
        case Conversation = "conversation"
    }
    public enum Origin {
        case track(SoundCloudKit.Track)
        case playlist(SoundCloudKit.Playlist)
    }
    public var type:      ActivityType
    public var createdAt: String
    public var tags:      [TagType]
    public var origin:    Origin

    public init(json: JSON) {
        type      = ActivityType(rawValue: json["type"].stringValue)!
        createdAt = json["created_at"].stringValue
        tags      = json["tags"].arrayValue.map { TagType(rawValue: $0.stringValue)! }
        switch type {
        case .Playlist:
            origin    = Origin.playlist(Playlist(json: json["origin"]))
        case .PlaylistRepost:
            origin    = Origin.playlist(Playlist(json: json["origin"]))
        default:
            origin    = Origin.track(Track(json: json["origin"]))
        }
    }
}

