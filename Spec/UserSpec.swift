//
//  UserSpec.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/21/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import SoundCloudKit

class UserSpec: QuickSpec {
    override func spec() {
        describe("a user") {
            it ("should be constructed with json") {
                let json = JSON(SpecHelper.fixtureJSONObject(fixtureNamed: "user")!)

                let user = User(json: json)
                expect(user.id).to(equal(3207))
                expect(user.permalink).to(equal("jwagener"))
                expect(user.username).to(equal("Johannes Wagener"))
                expect(user.uri).to(equal("http://api.soundcloud.com/users/3207"))
                expect(user.permalinkUrl).to(equal("http://soundcloud.com/jwagener"))
                expect(user.avatarUrl).to(equal("http://i1.sndcdn.com/avatars-000001552142-pbw8yd-large.jpg?142a848"))
                expect(user.country).to(equal("Germany"))
                expect(user.fullName).to(equal("Johannes Wagener"))
                expect(user.city).to(equal("Berlin"))
                expect(user.description).to(equal("<b>Hacker at SoundCloud</b>\r\n\r\nSome of my recent Hacks:\r\n\r\nsoundiverse.com \r\nbrowse recordings with the FiRe app by artwork\r\n\r\ntopbillin.com \r\nfind people to follow on SoundCloud\r\n\r\nchatter.fm \r\nget your account hooked up with a voicebox\r\n\r\nrecbutton.com \r\nrecord straight to your soundcloud account"))
                expect(user.discogsName).to(beNil())
                expect(user.myspaceName).to(beNil())
                expect(user.website).to(equal("http://johannes.wagener.cc"))
                expect(user.websiteTitle).to(equal("johannes.wagener.cc"))
                expect(user.online).to(beTruthy())
                expect(user.trackCount).to(equal(12))
                expect(user.playlistCount).to(equal(1))
                expect(user.followersCount).to(equal(417))
                expect(user.followingsCount).to(equal(174))
                expect(user.publicFavoritesCount).to(equal(26))
            }
        }
    }
}
