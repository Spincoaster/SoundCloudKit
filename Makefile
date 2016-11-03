XCODEBUILD:=xcodebuild

default: build test

build:
	$(XCODEBUILD) -scheme SoundCloudKit-iOS
	$(XCODEBUILD) -scheme SoundCloudKit-macOS
	$(XCODEBUILD) -scheme SoundCloudKit-tvOS
	$(XCODEBUILD) -scheme SoundCloudKit-watchOS

test:
	$(XCODEBUILD) -scheme SoundCloudKit-macOS test

clean:
	$(XCODEBUILD) -scheme SoundCloudKit-iOS clean
	$(XCODEBUILD) -scheme SoundCloudKit-macOS clean
	$(XCODEBUILD) -scheme SoundCloudKit-tvOS clean
	$(XCODEBUILD) -scheme SoundCloudKit-watchOS clean
archive:
	carthage build --no-skip-current
	carthage archive SoundCloudKit

.PHONY: test clean default
