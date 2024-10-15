import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_weight_app/util/func.dart';

const Duration maxCacheDuration = Duration(hours: 4);
DateTime? _appOpenLoadTime;

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  String get appOpeningUnitId => getAdId('appOpening');

  void loadAd() {
    AppOpenAd.load(
      adUnitId: appOpeningUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
          print('AppOpenAd !!');
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!isAdAvailable) {
      loadAd();
      return;
    }

    if (_isShowingAd) {
      return;
    }

    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );

    _appOpenAd!.show();
  }
}

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      _onAppStateChangedAd(state);
      // _onAppStateChangedPassword(state);
    });
  }

  void _onAppStateChangedAd(AppState appState) async {
    bool isPurchase = await isPurchasePremium();

    if (appState == AppState.foreground && isPurchase == false) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}
