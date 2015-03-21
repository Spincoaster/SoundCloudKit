//
//  Track.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/20/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON

enum Sharing: String {
    case Public  = "public"
    case Private = "private"
}

enum EmbeddableBy: String {
    case All  = "all"
    case Me   = "me"
    case None = "none"
}

enum EncodingState: String {
    case Processing = "processing"
    case Failed     = "failed"
    case Finished   = "finished"
}

enum License: String {
    case NoRightsReserved  = "no-rights-reserved"
    case AllRightsReserved = "all-rights-reserved"
    case CcBy              = "cc-by"
    case CcByNc            = "cc-by-nc"
    case CcByNd            = "cc-by-nd"
    case CcBySa            = "cc-by-sa"
    case CcByNcNd          = "cc-by-nc-nd"
    case CcByNcSa          = "cc-by-nc-sa"
}

enum TrackType: String {
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

class Track {
    let id:                  Int
    let createdAt:           String
    let userId:              Int
    let user:                User
    let title:               String
    let permalink:           String
    let permalinkUrl:        String
    let uri:                 String
    let sharing:             Sharing
    let embeddableBy:        EmbeddableBy
    let purchaseUrl:         String?
    let artworkUrl:          String?
    let description:         String?
    let label:               User
    let duration:            Int64
    let genre:               String?
    let tagList:             String
    let labelId:             Int64?
    let labelName:           String?
    let release:             Int?
    let releaseDay:          Int?
    let releaseMonth:        Int?
    let releaseYear:         Int?
    let streamable:          Bool
    let downloadable:        Bool
    let state:               EncodingState
    let license:             License
    let trackType:           TrackType
    let waveformUrl:         String
    let downloadUrl:         String
    let streamUrl:           String
    let videoUrl:            String?
    let bpm:                 Int?
    let commentable:         Bool
    let isrc:                String?
    let keySignature:        String?
    let commentCount:        Int
    let downloadCount:       Int
    let playbackCount:       Int
    let favoritingsCount:    Int
    let originalFormat:      String
    let originalContentSize: Int64
    let createdWith:         App
    
    init(json: JSON) {
        id                  = json["id"].intValue
        createdAt           = json["created_at"].stringValue
        userId              = json["user_id"].intValue
        user                = User(json: json["user"])
        title               = json["title"].stringValue
        permalink           = json["permalink"].stringValue
        permalinkUrl        = json["permalink_url"].stringValue
        uri                 = json["uri"].stringValue
        sharing             = Sharing(rawValue: json["sharing"].stringValue)!
        embeddableBy        = EmbeddableBy(rawValue: json["embeddable_by"].stringValue)!
        purchaseUrl         = json["purchase_url"].stringValue
        artworkUrl          = json["artwork_url"].stringValue
        description         = json["description"].stringValue
        label               = User(json: json["label"])
        duration            = json["description"].int64Value
        genre               = json["genre"].stringValue
        tagList             = json["tag_list"].stringValue
        labelId             = json["label_id"].int64Value
        labelName           = json["label_name"].stringValue
        release             = json["release"].intValue
        releaseDay          = json["release_day"].intValue
        releaseMonth        = json["release_month"].intValue
        releaseYear         = json["release_year"].intValue
        streamable          = json["streamable"].boolValue
        downloadable        = json["downloadable"].boolValue
        state               = EncodingState(rawValue: json["state"].stringValue)!
        license             = License(rawValue: json["license"].stringValue)!
        trackType           = TrackType(rawValue: json["track_type"].stringValue)!
        waveformUrl         = json["waveform_url"].stringValue
        downloadUrl         = json["download_url"].stringValue
        streamUrl           = json["stream_url"].stringValue
        videoUrl            = json["video_url"].stringValue
        bpm                 = json["bpm"].intValue
        commentable         = json["commentable"].boolValue
        isrc                = json["isrc"].stringValue
        keySignature        = json["key_signature"].stringValue
        commentCount        = json["comment_count"].intValue
        downloadCount       = json["download_count"].intValue
        playbackCount       = json["playback_count"].intValue
        favoritingsCount    = json["favoritings_count"].intValue
        originalFormat      = json["original_format"].stringValue
        originalContentSize = json["original_content_size"].int64Value
        createdWith         = App(json: json["created_with"])
    }
}

