import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/ids.dart';

class AdManager {
  static Future<BannerAd> loadBannerAd(BannerAdListener listener) async {
    final bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid ? bannerAdUnitIdAndroid : bannerAdUnitIos,
        listener: listener,
        request: const AdRequest());
    bannerAd.load();

    return bannerAd;
  }

  static void loadInterstitialAd(Function() onAdClosed) async {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? interstitialAdUnitIdAndroid
          : interstitialAdUnitIdIos,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              onAdClosed();
            },
          );
          ad.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
       
        },
      ),
    );
  }
}
