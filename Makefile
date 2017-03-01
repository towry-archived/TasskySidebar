did = "9C6CB3C6-D930-4012-9F8E-AB12EB7091F1"
XCODE_SCHEME="TasskySidebar"
XCODE_PROJECT="TasskySidebar.xcodeproj"
XCODE_WORKSPACE="TasskySidebar.xcworkspace"
SDK="iphonesimulator10.2"
BUNDLE_APP="build/Build/Products/Debug-iphonesimulator/TasskySidebar.app"

all:
	echo "Please run a specific target"

boot:
	nohup /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator -CurrentDeviceUDID $(did) > /tmp/simulator.log 2>&1&

build:
	xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-workspace $(XCODE_WORKSPACE) \
		-configuration Debug \
		-destination 'platform=iOS Simulator,name=iPhone 5s,OS=10.2' \
		-derivedDataPath \
		build

install:
	xcrun simctl install booted $(BUNDLE_APP)
run:
	xcrun simctl launch booted "me.towry.TasskySidebar"

.PHONY: boot build install run
