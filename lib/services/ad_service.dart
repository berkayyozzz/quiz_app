import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // REAL App ID provided by user
  static String get appId {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'ca-app-pub-6164147837428706~3309047040';
    }
    throw UnsupportedError('Unsupported platform');
  }


  // REAL Interstitial Ad Unit ID provided by user
  static String get interstitialAdUnitId {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'ca-app-pub-6164147837428706/3800001636';
    }
    throw UnsupportedError('Unsupported platform');
  }


  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  // Singleton pattern
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  /// Load the interstitial ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          print('AdMob: Interstitial ad loaded.');
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isAdLoaded = false;
          print('AdMob: Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  /// Show the interstitial ad if it's loaded
  void showInterstitialAd({Function? onAdDismissed}) {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _isAdLoaded = false;
          loadInterstitialAd(); // Load the next one
          if (onAdDismissed != null) onAdDismissed();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _isAdLoaded = false;
          loadInterstitialAd();
          if (onAdDismissed != null) onAdDismissed();
        },
      );
      _interstitialAd!.show();
    } else {
      print('AdMob: Interstitial ad not loaded yet.');
      if (onAdDismissed != null) onAdDismissed();
      loadInterstitialAd(); // Try loading again
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
