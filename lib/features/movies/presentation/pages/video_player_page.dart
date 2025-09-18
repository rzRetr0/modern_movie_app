import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:flutter/foundation.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;
  final String title;

  const VideoPlayerPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _isAdBlockerActive = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    // Ensure WebView platform is set
    if (WebViewPlatform.instance == null) {
      try {
        if (defaultTargetPlatform == TargetPlatform.android) {
          WebViewPlatform.instance = AndroidWebViewPlatform();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          WebViewPlatform.instance = WebKitWebViewPlatform();
        } else {
          // Fallback
          WebViewPlatform.instance = AndroidWebViewPlatform();
        }
      } catch (e) {
        // If platform detection fails, try Android as default
        WebViewPlatform.instance = AndroidWebViewPlatform();
      }
    }

    _controller = WebViewController();
    await _controller!.setJavaScriptMode(JavaScriptMode.unrestricted);
    await _controller!.setBackgroundColor(Colors.black);

    // Inject ad-blocking JavaScript
    await _controller!.addJavaScriptChannel(
      'AdBlock',
      onMessageReceived: (JavaScriptMessage message) {
        // Handle ad blocking messages if needed
      },
    );

    await _controller!.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {
          setState(() => _isLoading = true);
        },
        onPageFinished: (String url) async {
          // Inject ad-blocking script after page loads
          await _injectAdBlocker();
          // Start periodic ad blocking
          _startPeriodicAdBlocker();
          setState(() => _isLoading = false);
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );
    await _controller!.loadRequest(Uri.parse(widget.url));
    setState(() {});
  }

  Future<void> _injectAdBlocker() async {
    const adBlockScript = '''
      (function() {
        // Hide common ad elements
        var adSelectors = [
          '.ads',
          '.advertisement',
          '.ad-container',
          '.ad-banner',
          '.ad-wrapper',
          '.ad-slot',
          '.ad-unit',
          '.advert',
          '.sponsored',
          '.promo',
          '[id*="ad"]',
          '[class*="ad"]',
          '[id*="banner"]',
          '[class*="banner"]',
          '.popup',
          '.overlay',
          '.modal',
          '.interstitial'
        ];

        // Hide ad elements
        adSelectors.forEach(function(selector) {
          var elements = document.querySelectorAll(selector);
          elements.forEach(function(el) {
            el.style.display = 'none';
            el.style.visibility = 'hidden';
            el.remove();
          });
        });

        // Block common ad scripts
        var scripts = document.getElementsByTagName('script');
        for (var i = 0; i < scripts.length; i++) {
          var src = scripts[i].src;
          if (src && (
            src.includes('ads') ||
            src.includes('advertisement') ||
            src.includes('doubleclick') ||
            src.includes('googlesyndication') ||
            src.includes('googleadservices') ||
            src.includes('amazon-adsystem') ||
            src.includes('facebook.com/tr') ||
            src.includes('analytics')
          )) {
            scripts[i].remove();
          }
        }

        // Block ad iframes
        var iframes = document.getElementsByTagName('iframe');
        for (var i = 0; i < iframes.length; i++) {
          var src = iframes[i].src;
          if (src && (
            src.includes('ads') ||
            src.includes('advertisement') ||
            src.includes('doubleclick') ||
            src.includes('googlesyndication')
          )) {
            iframes[i].remove();
          }
        }

        // Remove ad-related meta tags
        var metaTags = document.getElementsByTagName('meta');
        for (var i = 0; i < metaTags.length; i++) {
          var name = metaTags[i].getAttribute('name');
          if (name && name.includes('ad')) {
            metaTags[i].remove();
          }
        }

        // Hide body margin/padding that might be for ads
        document.body.style.margin = '0';
        document.body.style.padding = '0';

        console.log('Ad blocker applied');
      })();
    ''';

    try {
      await _controller?.runJavaScript(adBlockScript);
    } catch (e) {
      // Ignore errors if script injection fails
    }
  }

  @override
  void dispose() {
    _stopPeriodicAdBlocker();
    super.dispose();
  }

  void _startPeriodicAdBlocker() {
    if (_isAdBlockerActive) return;
    _isAdBlockerActive = true;

    // Run ad blocker every 3 seconds for 2 minutes
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted || !_isAdBlockerActive) return;

      await _injectAdBlocker();

      // Continue for 2 minutes (40 iterations)
      for (int i = 0; i < 40 && mounted && _isAdBlockerActive; i++) {
        await Future.delayed(const Duration(seconds: 3));
        if (mounted && _isAdBlockerActive) {
          await _injectAdBlocker();
        }
      }

      _isAdBlockerActive = false;
    });
  }

  void _stopPeriodicAdBlocker() {
    _isAdBlockerActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                WebViewWidget(controller: _controller!),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }
}