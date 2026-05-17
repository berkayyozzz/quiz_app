import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

/// Premium abonelik yöneticisi
/// Aylık 49 TL — Reklamsız + Sınırsız Düello
class PremiumService extends ChangeNotifier {
  static final PremiumService _instance = PremiumService._internal();
  factory PremiumService() => _instance;
  PremiumService._internal();

  // ——— Product ID'leri ———
  // App Store Connect & Google Play Console'da tanımlayacağınız ID
  static const String _monthlySubscriptionId = 'yks_premium_monthly';

  // ——— State ———
  bool _isPremium = false;
  bool _isLoading = true;
  List<ProductDetails> _products = [];
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  List<ProductDetails> get products => _products;

  /// Uygulama açıldığında çağrılır
  Future<void> initialize() async {
    if (Platform.isIOS) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Önce local cache kontrol et
    await _loadCachedPremiumStatus();

    final available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Satın alma güncellemelerini dinle
    _purchaseSubscription = InAppPurchase.instance.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (error) {
        debugPrint('Purchase stream error: $error');
      },
    );

    // Ürünleri yükle
    await _loadProducts();

    // Mevcut satın alımları kontrol et (restore)
    await InAppPurchase.instance.restorePurchases();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadProducts() async {
    final response = await InAppPurchase.instance.queryProductDetails(
      {_monthlySubscriptionId},
    );

    if (response.error != null) {
      debugPrint('Product query error: ${response.error}');
      return;
    }

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('Products not found: ${response.notFoundIDs}');
    }

    _products = response.productDetails;
    notifyListeners();
  }

  /// Satın alma başlat
  Future<bool> purchasePremium() async {
    if (_products.isEmpty) {
      debugPrint('No products available to purchase');
      return false;
    }

    final product = _products.first;
    final purchaseParam = PurchaseParam(productDetails: product);

    try {
      return await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (e) {
      debugPrint('Purchase error: $e');
      return false;
    }
  }

  /// Satın alım güncellemelerini işle
  void _onPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      _handlePurchase(purchase);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored) {
      // Satın alma doğrulandı
      await _setPremiumStatus(true);

      // Firestore'a kaydet
      await _savePremiumToFirestore(true);
    } else if (purchase.status == PurchaseStatus.error) {
      debugPrint('Purchase error: ${purchase.error}');
    }

    // Bekleyen satın alımları tamamla
    if (purchase.pendingCompletePurchase) {
      await InAppPurchase.instance.completePurchase(purchase);
    }
  }

  /// Satın almayı geri yükle
  Future<void> restorePurchases() async {
    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (e) {
      debugPrint('Restore error: $e');
    }
  }

  /// Premium durumunu kaydet
  Future<void> _setPremiumStatus(bool value) async {
    _isPremium = value;
    notifyListeners();

    final uid = AuthService().currentUser?.uid;
    if (uid != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_premium_$uid', value);
    }
  }

  /// Çıkış yapıldığında veya hesap değiştiğinde durumu temizle
  Future<void> clearPremiumStatus() async {
    _isPremium = false;
    notifyListeners();
  }

  /// Önceki durumu yükle
  Future<void> _loadCachedPremiumStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = AuthService().currentUser?.uid;
      
      if (uid == null) {
        _isPremium = false;
        notifyListeners();
        return;
      }

      _isPremium = prefs.getBool('is_premium_$uid') ?? false;

      // Firestore'dan da kontrol et
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
          
      if (doc.exists) {
        final data = doc.data();
        final bool isFirestorePremium = data != null && data['isPremium'] == true;
        
        _isPremium = isFirestorePremium;
        await prefs.setBool('is_premium_$uid', isFirestorePremium);
      }
    } catch (e) {
      debugPrint('Error loading premium status: $e');
    }
    notifyListeners();
  }

  /// Firestore'a premium durumunu kaydet
  Future<void> _savePremiumToFirestore(bool value) async {
    try {
      final uid = AuthService().currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'isPremium': value,
          'premiumSince': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      debugPrint('Error saving premium to Firestore: $e');
    }
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    super.dispose();
  }
}
