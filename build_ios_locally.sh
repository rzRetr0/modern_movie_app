#!/bin/bash
echo "🔨 Building Merl Cinema iOS App Locally..."
echo "📱 This script cleans and regenerates the iOS project to fix CocoaPods issues"
echo ""

# Check prerequisites
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Install Flutter first:"
    echo "   https://flutter.dev/docs/get-started/install"
    exit 1
fi

if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode not found. Install Xcode from App Store"
    exit 1
fi

echo "✅ Prerequisites check passed"

# Clean everything
echo "🧹 Cleaning previous builds..."
flutter clean
rm -rf ios/Pods ios/Podfile.lock build/ios

# Regenerate iOS project
echo "🔄 Regenerating iOS project..."
flutter create --platforms=ios --org com.movieapp .

# Build iOS app
echo "🔨 Building iOS app..."
if flutter build ios --release --no-codesign; then
    echo ""
    echo "✅ iOS BUILD SUCCESSFUL!"
    echo "📦 App location: build/ios/iphoneos/Runner.app"
    echo "📏 App size:"
    du -sh build/ios/iphoneos/Runner.app
    echo ""
    echo "📱 To test on simulator:"
    echo "   flutter run --device-id=YOUR_SIMULATOR_ID"
    echo ""
    echo "📦 To create IPA for distribution:"
    echo "   1. Open Xcode: open ios/Runner.xcworkspace"
    echo "   2. Product → Archive"
    echo "   3. Distribute App → Development/Ad Hoc"
    echo ""
    echo "🎉 Your iOS movie app is ready!"
else
    echo ""
    echo "❌ Build failed. Common solutions:"
    echo "   1. Run: flutter doctor"
    echo "   2. Accept Xcode license: sudo xcodebuild -license accept"
    echo "   3. Update CocoaPods: sudo gem install cocoapods"
    echo "   4. Clean and retry: flutter clean && flutter pub get"
    echo ""
    echo "💡 If you still get CocoaPods errors, try:"
    echo "   rm -rf ios/Pods ios/Podfile.lock"
    echo "   cd ios && pod install"
fi