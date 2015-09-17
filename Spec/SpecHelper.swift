//
//  SpecHelper.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Foundation

public class SpecHelper {
    public class func fixtureJSONObject(fixtureNamed fixtureNamed: String) -> AnyObject? {
        let bundle   = NSBundle(forClass: SpecHelper.self)
        let filePath = bundle.pathForResource(fixtureNamed, ofType: "json")
        let data     = NSData(contentsOfFile: filePath!)
        let jsonObject : AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
        return jsonObject
    }
}
