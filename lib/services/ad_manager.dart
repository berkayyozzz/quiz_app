import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class AdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;
  static bool _isPushed = false;

  static RewardedAd? _rewardedAd;
  static bool _isRewardedAdLoaded = false;

  /// Canlı Reklam ID'leri
  static const String _iosRealAdUnitId = 'ca-app-pub-6164147837428706/3800001636';
  // TODO: Kullanıcı Android ID'yi verdiğinde burayı güncelleyin!
  static const String _androidRealAdUnitId = 'ca-app-pub-6164147837428706/7867727826';

  /// Ödül Reklam ID'leri
  // TODO: AdMob panelinden Rewarded Ad Unit ID'lerini oluşturup burayı güncelleyin!
  static const String _iosRewardedAdUnitId = 'ca-app-pub-6164147837428706/3965074048';
  static const String _androidRewardedAdUnitId = 'ca-app-pub-6164147837428706/7824428003';

  /// Google Mobile Ads Test Interstitial ID'leri
  static String get interstitialAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return _iosRealAdUnitId;
      } else if (Platform.isAndroid) {
        return _androidRealAdUnitId;
      }
    }
    // Debug modunda test kimliklerini kullanıyoruz ki hesabınız kısıtlanmasın
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Android Test Interstitial
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // iOS Test Interstitial
    }
    throw UnsupportedError('Desteklenmeyen platform');
  }

  /// App Tracking Transparency izin istemi
  static Future<void> requestTrackingAuthorization() async {
    if (Platform.isIOS) {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await Future.delayed(const Duration(milliseconds: 200));
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    }
  }

  /// Geçiş Reklamını yükle (Sınava girildiğinde önceden yüklemekte fayda var)
  static void loadInterstitialAd() {
    print("Reklam yükleniyor...");
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          print("Geçiş reklamı yüklendi.");
        },
        onAdFailedToLoad: (error) {
          print('Geçiş reklamı yüklenemedi. Hata Kodu: ${error.code}, Mesaj: ${error.message}');
          _isAdLoaded = false;
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Quizi bitirirken reklamı gösterip, callback üzerinden ResultScreen gibi diğer ekranlara geçisi sağla
  static void showInterstitialAd({required VoidCallback onAdDismissed}) {
    // Sadece bir kere push edilmesini garantiye almak için _isPushed bayrağı
    _isPushed = false;

    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          print('Reklam ekranda gösterildi.');
        },
        onAdDismissedFullScreenContent: (ad) {
          print('Reklam kapatıldı.');
          ad.dispose();
          _interstitialAd = null;
          _isAdLoaded = false;
          
          if (!_isPushed) {
            _isPushed = true;
            onAdDismissed();
          }
          
          // Tekrardan kullanamayacağımız için arka planda yeni bir tane yükleyebiliriz
          loadInterstitialAd(); 
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Reklam gösterilemedi: \${error.message}');
          ad.dispose();
          _interstitialAd = null;
          _isAdLoaded = false;
          if (!_isPushed) {
            _isPushed = true;
            onAdDismissed();
          }
        },
      );

      _interstitialAd!.show();
      _interstitialAd = null; // Bir kere gösterilen reklamı kullanımdan düşürüyoruz
    } else {
      print('Reklam henüz hazır değil (AdLoaded: $_isAdLoaded). Sonuç ekranına geçiliyor...');
      if (!_isPushed) {
        _isPushed = true;
        onAdDismissed();
      }
    }
  }

  /// Ödül Reklamı Ad Unit ID
  static String get rewardedAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return _iosRewardedAdUnitId;
      } else if (Platform.isAndroid) {
        return _androidRewardedAdUnitId;
      }
    }
    // Debug modunda test kimliklerini kullanıyoruz
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Android Test Rewarded
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // iOS Test Rewarded
    }
    throw UnsupportedError('Desteklenmeyen platform');
  }

  /// Ödül Reklamını yükle
  static void loadRewardedAd() {
    print("Ödül reklamı yükleniyor...");
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedAdLoaded = true;
          print("Ödül reklamı yüklendi.");
        },
        onAdFailedToLoad: (error) {
          print('Ödül reklamı yüklenemedi. Hata: ${error.message}');
          _isRewardedAdLoaded = false;
          _rewardedAd = null;
        },
      ),
    );
  }

  /// Ödül reklamının yüklenip yüklenmediğini kontrol et
  static bool get isRewardedAdLoaded => _isRewardedAdLoaded;

  /// Ödül Reklamını göster
  static void showRewardedAd({
    required VoidCallback onRewarded,
    VoidCallback? onAdFailed,
  }) {
    if (_isRewardedAdLoaded && _rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          print('Ödül reklamı ekranda gösterildi.');
        },
        onAdDismissedFullScreenContent: (ad) {
          print('Ödül reklamı kapatıldı.');
          ad.dispose();
          _rewardedAd = null;
          _isRewardedAdLoaded = false;
          // Yeni bir tane yükle
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Ödül reklamı gösterilemedi: ${error.message}');
          ad.dispose();
          _rewardedAd = null;
          _isRewardedAdLoaded = false;
          onAdFailed?.call();
          loadRewardedAd();
        },
      );

      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          print('Kullanıcı ödül kazandı: ${reward.amount} ${reward.type}');
          onRewarded();
        },
      );
    } else {
      print('Ödül reklamı henüz hazır değil.');
      onAdFailed?.call();
    }
  }
}
