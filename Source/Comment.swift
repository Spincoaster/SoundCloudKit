//
//  Comment.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 8/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Comment {
    public let id:        Int
    public let createdAt: String
    public let userId:    Int
    public let trackId:   Int
    public let timestamp: Int64
    public let body:      String
    public let uri:       String
    public let user:      User

    public init(json: JSON) {
        id        = json["id"].intValue
        createdAt = json["created_at"].stringValue
        userId    = json["user_id"].intValue
        trackId   = json["track_id"].intValue
        timestamp = json["timestamp"].int64Value
        body      = json["body"].stringValue
        uri       = json["uri"].stringValue
        user      = User(json: json["user"])
    }
}