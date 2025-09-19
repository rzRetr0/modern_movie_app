# Codemagic CI/CD Setup for Merl Cinema

This guide shows how to set up Codemagic for building your Flutter movie app across all platforms.

## 🚀 Quick Start

### 1. Connect Your Repository
1. Go to [Codemagic](https://codemagic.io)
2. Sign up/Sign in
3. Click "Add application"
4. Connect your GitHub repository
5. Select Flutter as the project type

### 2. Configuration
Codemagic will automatically detect the `codemagic.yaml` file in your repository.

## 📱 Available Workflows

### Individual Platform Builds
- **iOS Workflow**: `ios-workflow` - Builds iOS app only
- **Android Workflow**: `android-workflow` - Builds Android APK/AAB
- **Web Workflow**: `web-workflow` - Builds web app

### All Platforms Build
- **All Platforms**: `all-platforms` - Builds iOS, Android, and Web simultaneously

## 🔧 Environment Setup

### For iOS Builds
Codemagic handles iOS builds much better than GitHub Actions:
- ✅ **Native macOS environment** (M2 Mac mini)
- ✅ **Latest Xcode** automatically available
- ✅ **CocoaPods** properly configured
- ✅ **Code signing** support (optional)

### For Android Builds
- ✅ **Linux environment** optimized for Android
- ✅ **Java 17** pre-installed
- ✅ **Android SDK** fully configured

### For Web Builds
- ✅ **Fast Linux builds**
- ✅ **Node.js** for web deployment

## 📦 Build Artifacts

After successful builds, you'll get:

### iOS
- `Runner.app` - iOS application bundle
- `merl-cinema-ios.ipa` - Unsigned IPA file

### Android
- `app-release.apk` - Android APK
- `app-release.aab` - Android App Bundle

### Web
- `build/web/` - Complete web application

## 🔐 Code Signing (Optional)

### For iOS
1. Go to Codemagic → Your App → Settings
2. Add your Apple Developer certificates
3. Configure provisioning profiles
4. Enable "Code signing" in the workflow

### For Android
1. Add your keystore file
2. Set keystore password and key alias
3. Configure signing in the workflow

## 🚀 Publishing (Optional)

### App Store Connect
Set these environment variables:
- `APP_STORE_CONNECT_PRIVATE_KEY`
- `APP_STORE_CONNECT_KEY_IDENTIFIER`
- `APP_STORE_CONNECT_ISSUER_ID`

### Google Play
Set this environment variable:
- `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`

## 🎯 Usage

### Manual Builds
1. Go to Codemagic dashboard
2. Select your app
3. Click "Start new build"
4. Choose workflow (iOS/Android/Web/All)
5. Click "Start build"

### Automatic Builds
- **Push to main**: Triggers all-platforms build
- **Pull requests**: Triggers all-platforms build
- **Tag pushes**: Can trigger release builds

## 📊 Build Status

Monitor your builds:
- ✅ **Green**: Build successful
- ❌ **Red**: Build failed
- ⏳ **Yellow**: Build in progress

## 🐛 Troubleshooting

### iOS Build Issues
- Check Xcode version compatibility
- Verify CocoaPods installation
- Ensure proper code signing setup

### Android Build Issues
- Check Java version (17 recommended)
- Verify Android SDK setup
- Check keystore configuration

### Web Build Issues
- Check Flutter web support
- Verify Node.js availability

## 💰 Pricing

Codemagic offers:
- **Free tier**: 500 minutes/month
- **Pay-as-you-go**: Additional minutes available
- **Team plans**: For larger teams

## 🎉 Success!

With Codemagic, you'll get:
- ✅ **Reliable iOS builds** (no CocoaPods issues)
- ✅ **Fast Android builds**
- ✅ **Web deployment ready**
- ✅ **Professional CI/CD pipeline**

**Your Flutter movie app will build successfully across all platforms!** 🎬📱

---

**Need help?** Check Codemagic documentation or their support team!