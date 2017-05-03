//
//  StringExtension.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 2017/05/03.
//  Copyright © 2017 Spincoaster. All rights reserved.
//

import Foundation

extension String {
    func toURL() -> URL? {
        if let url = URL(string: self) {
            return url
        } else if let str = addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return URL(string: str)
        }
        return nil
    }
    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
