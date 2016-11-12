//
//  Track.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/20/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON
import Breit


public enum Sharing: String {
    case `public`  = "public"
    case `private` = "private"
}

public enum EmbeddableBy: String {
    case all  = "all"
    case me   = "me"
    case none = "none"
}

public enum EncodingState: String {
    case processing = "processing"
    case failed     = "failed"
    case finished   = "finished"
}

public enum License: String {
    case no_rights_reserved  = "no-rights-reserved"
    case all_rights_reserved = "all-rights-reserved"
    case cc_by               = "cc-by"
    case cc_by_nc            = "cc-by-nc"
    case cc_by_nd            = "cc-by-nd"
    case cc_by_sa            = "cc-by-sa"
    case cc_by_nc_nd         = "cc-by-nc-nd"
    case cc_by_nc_sa         = "cc-by-nc-sa"
}

public enum TrackType: String {
    case original     = "original"
    case remix        = "remix"
    case live         = "live"
    case recording    = "recording"
    case spoken       = "spoken"
    case podcast      = "podcast"
    case demo         = "demo"
    case in_progress  = "in progress"
    case stem         = "stem"
    case loop         = "loop"
    case sound_effect = "sound effect"
    case sample       = "sample"
    case other        = "other"
}

public enum ArtworkType: String {
    case t500x500  = "t500x500"
    case crop      = "crop"
    case t300x300  = "t300x300"
    case large     = "large"
    case t67x67    = "t67x67"
    case badge     = "badge"
    case small     = "small"
    case tiny      = "tiny"
    case mini      = "mini"
}

public struct Track: Hashable, Equatable, JSONInitializable {
    public let id:                  Int
    public let createdAt:           String
    public let userId:              Int
    public let user:                User
    public let title:               String
    public let permalink:           String
    public let permalinkUrl:        String
    public let uri:                 String
    public let sharing:             Sharing
    public let embeddableBy:        EmbeddableBy?
    public let purchaseUrl:         String?
    public let artworkUrl:          String?
    public let description:         String?
    public let label:               User
    public let duration:            Int64
    public let genre:               String?
    public let tagList:             String
    public let labelId:             Int64?
    public let labelName:           String?
    public let release:             Int?
    public let releaseDay:          Int?
    public let releaseMonth:        Int?
    public let releaseYear:         Int?
    public let streamable:          Bool
    public let downloadable:        Bool
    public let state:               EncodingState
    public let license:             License
    public let trackType:           TrackType?
    public let waveformUrl:         String
    public let downloadUrl:         String
    public let streamUrl:           String
    public let videoUrl:            String?
    public let bpm:                 Int?
    public let commentable:         Bool
    public let isrc:                String?
    public let keySignature:        String?
    public let commentCount:        Int
    public let downloadCount:       Int
    public let playbackCount:       Int
    public let favoritingsCount:    Int
    public let originalFormat:      String
    public let originalContentSize: Int64
    public let createdWith:         App

    public let attachmentsUri:      String?

    public var hashValue: Int {
        return id.hashValue
    }

    public var thumbnailURL: URL? {
        if let url = artworkUrl?.toURL() {
            return url
        } else if let url = user.avatarUrl.toURL() {
            return url
        } else {
            return nil
        }
    }

    public var artworkURL: URL? {
        return getArtworURL(.t500x500)
    }

    public func getArtworURL(_ type: ArtworkType) -> URL? {
        guard let artworkUrl = artworkUrl else { return thumbnailURL }
        if let url = URL(string: artworkUrl.replace("large", withString: type.rawValue)) {
            return url
        }
        return thumbnailURL
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
        state               = EncodingState(rawValue: json["state"].stringValue)!
        license             = License(rawValue: json["license"].stringValue)!
        trackType           = TrackType(rawValue: json["track_type"].stringValue)
        waveformUrl         = json["waveform_url"].stringValue
        downloadUrl         = json["download_url"].stringValue
        streamUrl           = json["stream_url"].stringValue
        videoUrl            = json["video_url"].string
        bpm                 = json["bpm"].int
        commentable         = json["commentable"].boolValue
        isrc                = json["isrc"].string
        keySignature        = json["key_signature"].string
        commentCount        = json["comment_count"].intValue
        downloadCount       = json["download_count"].intValue
        playbackCount       = json["playback_count"].intValue
        favoritingsCount    = json["favoritings_count"].intValue
        originalFormat      = json["original_format"].stringValue
        originalContentSize = json["original_content_size"].int64Value
        createdWith         = App(json: json["created_with"])

        attachmentsUri      = json["attachments_uri"].string
    }
}

public func ==(lhs: Track, rhs: Track) -> Bool {
    return lhs.id == rhs.id
}

