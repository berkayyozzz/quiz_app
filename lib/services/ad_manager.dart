import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class AdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;
  static bool _isPushed = false;

  /// Canlı Reklam ID'leri
  static const String _iosRealAdUnitId = 'ca-app-pub-6164147837428706/3800001636';
  // TODO: Kullanıcı Android ID'yi verdiğinde burayı güncelleyin!
  static const String _androidRealAdUnitId = 'ca-app-pub-6164147837428706/7867727286';

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
          print('Geçiş reklamı yüklenemedi: \${error.message}');
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
      print('Reklam henüz hazır değil. Sonuç ekranına geçiliyor...');
      if (!_isPushed) {
        _isPushed = true;
        onAdDismissed();
      }
    }
  }
}
