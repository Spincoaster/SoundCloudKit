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
    case Public  = "public"
    case Private = "private"
}

public enum EmbeddableBy: String {
    case All  = "all"
    case Me   = "me"
    case None = "none"
}

public enum EncodingState: String {
    case Processing = "processing"
    case Failed     = "failed"
    case Finished   = "finished"
}

public enum License: String {
    case NoRightsReserved  = "no-rights-reserved"
    case AllRightsReserved = "all-rights-reserved"
    case CcBy              = "cc-by"
    case CcByNc            = "cc-by-nc"
    case CcByNd            = "cc-by-nd"
    case CcBySa            = "cc-by-sa"
    case CcByNcNd          = "cc-by-nc-nd"
    case CcByNcSa          = "cc-by-nc-sa"
}

public enum TrackType: String {
    case Original    = "original"
    case Remix       = "remix"
    case Live        = "live"
    case Recording   = "recording"
    case Spoken      = "spoken"
    case Podcast     = "podcast"
    case Demo        = "demo"
    case InProgress  = "in progress"
    case Stem        = "stem"
    case Loop        = "loop"
    case SoundEffect = "sound effect"
    case Sample      = "sample"
    case Other       = "other"
}

public enum ArtworkType: String {
    case T500x500  = "t500x500"
    case Crop      = "crop"
    case T300x300  = "t300x300"
    case Large     = "large"
    case T67x67    = "t67x67"
    case Badge     = "badge"
    case Small     = "small"
    case Tiny      = "tiny"
    case Mini      = "mini"
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
        return getArtworURL(.T500x500)
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

