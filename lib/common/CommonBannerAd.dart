import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/func.dart';

class CommonBannerAd extends StatefulWidget {
  const CommonBannerAd({super.key});

  @override
  State<CommonBannerAd> createState() => _CommonBannerAdState();
}

class _CommonBannerAdState extends State<CommonBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: getAdId('banner'),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    loadAd();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 50,
        child: _isLoaded
            ? AdWidget(ad: _bannerAd!)
            : Center(child: CommonText(text: 'ads', isNotTr: true)),
      ),
    );
  }
}
