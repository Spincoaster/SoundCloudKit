//
//  App.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Foundation
import SwiftyJSON

class App {
    let id: Int
    let uri: String
    let permalinkUrl: String
    let externalUrl: String
    let creator: String
    init(json: JSON) {
        id           = json["id"].intValue
        uri          = json["uri"].stringValue
        permalinkUrl = json["permalink_url"].stringValue
        externalUrl  = json["external_url"].stringValue
        creator      = json["creator"].stringValue
    }
}