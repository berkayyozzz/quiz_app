import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/premium_service.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen>
    with SingleTickerProviderStateMixin {
  bool _isPurchasing = false;
  bool _isRestoring = false;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _handlePurchase() async {
    setState(() => _isPurchasing = true);

    final success = await PremiumService().purchasePremium();

    if (mounted) {
      setState(() => _isPurchasing = false);

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Satın alma başlatılamadı. Lütfen tekrar deneyin.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _handleRestore() async {
    setState(() => _isRestoring = true);

    await PremiumService().restorePurchases();

    if (mounted) {
      setState(() => _isRestoring = false);

      if (PremiumService().isPremium) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Premium üyelik geri yüklendi! 🎉'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aktif bir abonelik bulunamadı.'),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final premiumService = PremiumService();

    // Eğer zaten premium ise
    if (premiumService.isPremium) {
      return _buildAlreadyPremium();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D0D1A),
              Color(0xFF1A1036),
              Color(0xFF2D1B69),
              Color(0xFF0D0D1A),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Geri butonu
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white54, size: 22),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Crown icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('👑', style: TextStyle(fontSize: 48)),
                    ),
                  )
                      .animate()
                      .scale(
                          duration: 800.ms, curve: Curves.elasticOut)
                      .then()
                      .shimmer(
                          duration: 2000.ms,
                          color: Colors.white.withOpacity(0.3)),

                  const SizedBox(height: 24),

                  // Başlık
                  Text(
                    'YKS Premium',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                        ).createShader(
                            const Rect.fromLTWH(0, 0, 250, 40)),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),

                  const SizedBox(height: 8),

                  Text(
                    'Sınav hazırlığını bir üst seviyeye taşı!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 40),

                  // Özellikler listesi
                  _buildFeatureItem(
                    icon: Icons.block,
                    title: 'Reklamsız Deneyim',
                    subtitle:
                        'Tüm geçiş ve ödül reklamları kaldırılır',
                    color: const Color(0xFFFF6B6B),
                    delay: 400,
                  ),
                  _buildFeatureItem(
                    icon: Icons.all_inclusive,
                    title: 'Sınırsız Düello',
                    subtitle: 'Bilet limiti olmadan istediğin kadar düello yap',
                    color: const Color(0xFF6C63FF),
                    delay: 500,
                  ),
                  _buildFeatureItem(
                    icon: Icons.replay,
                    title: 'Yanlışları Sınırsız Tekrar Çöz',
                    subtitle:
                        'Reklam izlemeden yanlış soruları tekrar çöz',
                    color: const Color(0xFF4ECDC4),
                    delay: 600,
                  ),
                  _buildFeatureItem(
                    icon: Icons.workspace_premium,
                    title: 'Premium Rozet',
                    subtitle:
                        'Sıralama tablosunda özel premium rozeti',
                    color: const Color(0xFFFFD700),
                    delay: 700,
                  ),
                  _buildFeatureItem(
                    icon: Icons.support_agent,
                    title: 'Öncelikli Destek',
                    subtitle: 'Sorularına öncelikli yanıt al',
                    color: const Color(0xFFFF8C42),
                    delay: 800,
                  ),

                  const SizedBox(height: 40),

                  // Fiyat kartı
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFD700).withOpacity(0.15),
                          const Color(0xFFFFA500).withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFFFFD700).withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '₺49',
                              style: GoogleFonts.poppins(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFD700),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '/ ay',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'İstediğin zaman iptal et',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 900.ms).scale(
                      begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: 24),

                  // Satın al butonu
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFD700),
                            Color(0xFFFFA500),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD700)
                                .withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed:
                            _isPurchasing ? null : _handlePurchase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: _isPurchasing
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.black87,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.diamond,
                                      color: Colors.black87,
                                      size: 22),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Premium\'a Geç',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 1000.ms)
                      .then()
                      .shimmer(
                          duration: 2500.ms,
                          color: Colors.white.withOpacity(0.2)),

                  const SizedBox(height: 16),

                  // Geri yükle butonu
                  TextButton(
                    onPressed: _isRestoring ? null : _handleRestore,
                    child: _isRestoring
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white54,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Geri yükleniyor...',
                                style: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Satın almayı geri yükle',
                            style: GoogleFonts.poppins(
                              color: Colors.white54,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white38,
                            ),
                          ),
                  ).animate().fadeIn(delay: 1100.ms),

                  const SizedBox(height: 12),

                  // Yasal bilgi
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Ödeme Apple/Google hesabınız üzerinden alınır. '
                      'Abonelik her ay otomatik olarak yenilenir. '
                      'Dönem sona ermeden en az 24 saat önce iptal '
                      'edebilirsiniz.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white24,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required int delay,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.check_circle, color: color, size: 22),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.15);
  }

  Widget _buildAlreadyPremium() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D0D1A),
              Color(0xFF1A1036),
              Color(0xFF0D0D1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFFFFD700).withOpacity(0.5),
                          blurRadius: 40,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: const Center(
                      child:
                          Text('👑', style: TextStyle(fontSize: 56)),
                    ),
                  ).animate().scale(curve: Curves.elasticOut),
                  const SizedBox(height: 32),
                  Text(
                    'Premium Aktif!',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFD700),
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 12),
                  Text(
                    'Tüm premium özelliklerin zaten aktif. '
                    'Reklamsız ve sınırsız deneyimin keyfini çıkar!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white54,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFFFFD700), width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Geri Dön',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFFFFD700),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
