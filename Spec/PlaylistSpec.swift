//
//  PlaylistSpec.swift
//  SoundCloudKit
//
//  Created by Hiroki Kumamoto on 3/22/15.
//  Copyright (c) 2015 Spincoaster. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import SoundCloudKit

class PlaylistSpec: QuickSpec {
    override func spec() {
        describe("a playlist") {
            it ("should be constructed with json") {
                let json = JSON(SpecHelper.fixtureJSONObject(fixtureNamed: "playlist")!)

                let playlist = Playlist(json: json)
                expect(playlist.id).to(equal(405726))
                expect(playlist.createdAt).to(equal("2010/11/02 09:24:50 +0000"))
                expect(playlist.userId).to(equal(3207))
                expect(playlist.duration).to(equal(154516))
                expect(playlist.sharing).to(equal(Sharing.Public))
                expect(playlist.tagList).to(equal(""))
                expect(playlist.permalink).to(equal("field-recordings"))
                expect(playlist.trackCount).to(equal(5))
                expect(playlist.streamable).to(beTruthy())
                expect(playlist.downloadable).to(beTruthy())
                expect(playlist.embeddableBy).to(equal(EmbeddableBy.Me))
                expect(playlist.purchaseUrl).to(beNil())
                expect(playlist.labelId).to(beNil())
                expect(playlist.playlistType).to(equal(PlaylistType.Other))
                expect(playlist.ean).to(equal(""))
                expect(playlist.description).to(equal("a couple of field recordings to test http://soundiverse.com.\r\n\r\nrecorded with the fire recorder: http://soundcloud.com/apps/fire"))
                expect(playlist.genre).to(equal(""))
                expect(playlist.labelName).to(equal(""))
                expect(playlist.title).to(equal("Field Recordings"))
                expect(playlist.releaseYear).to(beNil())
                expect(playlist.releaseMonth).to(beNil())
                expect(playlist.releaseDay).to(beNil())
                expect(playlist.uri).to(equal("http://api.soundcloud.com/playlists/405726"))
                expect(playlist.permalinkUrl).to(equal("http://soundcloud.com/jwagener/sets/field-recordings"))
                expect(playlist.artworkUrl).to(equal("http://i1.sndcdn.com/artworks-000025801802-1msl1i-large.jpg?5e64f12"))

                expect(playlist.user).notTo(beNil())

                expect(playlist.tracks).notTo(beNil())
                expect(playlist.tracks.count).to(equal(5))
            }
        }
    }
}
