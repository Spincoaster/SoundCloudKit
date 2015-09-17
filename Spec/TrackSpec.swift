//
//  TrackSpec.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/22/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import SoundCloudKit

class TrackSpec: QuickSpec {
    override func spec() {
        describe("a track") {
            it ("should be constructed with json") {
                let json = JSON(SpecHelper.fixtureJSONObject(fixtureNamed: "track")!)

                let track = Track(json: json)
                expect(track.id).to(equal(13158665))
                expect(track.createdAt).to(equal("2011/04/06 15:37:43 +0000"))
                expect(track.userId).to(equal(3699101))
                expect(track.duration).to(equal(18109))
                expect(track.commentable).to(beTruthy())
                expect(track.state).to(equal(EncodingState.Finished))
                expect(track.sharing).to(equal(Sharing.Public))
                expect(track.tagList).to(equal("soundcloud:source=iphone-record"))
                expect(track.permalink).to(equal("munching-at-tiannas-house"))
                expect(track.description).to(beNil())
                expect(track.streamable).to(beTruthy())
                expect(track.downloadable).to(beTruthy())
                expect(track.genre).to(beNil())
                expect(track.release).to(beNil())
                expect(track.purchaseUrl).to(beNil())
                expect(track.labelId).to(beNil())
                expect(track.labelName).to(beNil())
                expect(track.isrc).to(beNil())
                expect(track.videoUrl).to(beNil())
                expect(track.trackType).to(equal(TrackType.Recording))
                expect(track.keySignature).to(beNil())
                expect(track.bpm).to(beNil())
                expect(track.title).to(equal("Munching at Tiannas house"))
                expect(track.releaseYear).to(beNil())
                expect(track.releaseMonth).to(beNil())
                expect(track.releaseDay).to(beNil())
                expect(track.originalFormat).to(equal("m4a"))
                expect(track.originalContentSize).to(equal(10211857))
                expect(track.license).to(equal(License.AllRightsReserved))
                expect(track.uri).to(equal("http://api.soundcloud.com/tracks/13158665"))
                expect(track.permalinkUrl).to(equal("http://soundcloud.com/user2835985/munching-at-tiannas-house"))
                expect(track.artworkUrl).to(beNil())
                expect(track.waveformUrl).to(equal("http://w1.sndcdn.com/fxguEjG4ax6B_m.png"))

                expect(track.user).notTo(beNil())
                expect(track.user.id).to(equal(3699101))
                expect(track.user.permalink).to(equal("user2835985"))
                expect(track.user.username).to(equal("user2835985"))
                expect(track.user.uri).to(equal("http://api.soundcloud.com/users/3699101"))
                expect(track.user.permalinkUrl).to(equal("http://soundcloud.com/user2835985"))
                expect(track.user.avatarUrl).to(equal("http://a1.sndcdn.com/images/default_avatar_large.png?142a848"))

                expect(track.streamUrl).to(equal("http://api.soundcloud.com/tracks/13158665/stream"))
                expect(track.downloadUrl).to(equal("http://api.soundcloud.com/tracks/13158665/download"))
                expect(track.playbackCount).to(equal(0))
                expect(track.downloadCount).to(equal(0))
                expect(track.favoritingsCount).to(equal(0))
                expect(track.commentCount).to(equal(0))

                expect(track.createdWith).notTo(beNil())
                expect(track.createdWith.id).to(equal(124))
                expect(track.createdWith.name).to(equal("SoundCloud iPhone"))
                expect(track.createdWith.uri).to(equal("http://api.soundcloud.com/apps/124"))
                expect(track.createdWith.permalinkUrl).to(equal("http://soundcloud.com/apps/iphone"))

                expect(track.attachmentsUri).to(equal("http://api.soundcloud.com/tracks/13158665/attachments"))
            }
        }
    }
}
