//
//  App.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import SwiftyJSON

public class App {
    public let id: Int
    public let uri: String
    public let permalinkUrl: String
    public let externalUrl: String
    public let name: String
    public init(json: JSON) {
        id           = json["id"].intValue
        uri          = json["uri"].stringValue
        permalinkUrl = json["permalink_url"].stringValue
        externalUrl  = json["external_url"].stringValue
        name         = json["name"].stringValue
    }
}