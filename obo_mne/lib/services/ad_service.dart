import 'package:flutter/material.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  bool _isInitialized = false;

  Future<void> initialize() async {
    _isInitialized = true;
    print('Ad Service initialized');
  }

  Widget createBannerAd() {
    return CustomBannerAd();
  }

  void showInterstitialAd() {
    print('Interstitial ad would be shown here');
  }

  void loadInterstitialAd() {
    print('Interstitial ad loaded');
  }
}

class CustomBannerAd extends StatelessWidget {
  const CustomBannerAd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 55, 255, 188),
            const Color.fromARGB(255, 2, 60, 16),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.ads_click,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Підтримайте meow!',
                style: TextStyle(
                  color: const Color.fromARGB(255, 2, 60, 16),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                'Банер',
                style: TextStyle(
                  color: const Color.fromARGB(255, 2, 60, 16),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '*Тиць*',
              style: TextStyle(
                color: const Color.fromARGB(255, 2, 60, 16),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}