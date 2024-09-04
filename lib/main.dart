import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_weight_app/page/HomePage.dart';
import 'package:my_weight_app/page/StartPage.dart';
import 'package:my_weight_app/provider/PremiumProvider.dart';
import 'package:my_weight_app/provider/ReloadProvider.dart';
import 'package:my_weight_app/provider/SelectedDateTimeProvider.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:provider/provider.dart';

// final purchasesConfiguration =
//     PurchasesConfiguration(Platform.isIOS ? appleApiKey : googleApiKey);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();
  await EasyLocalization.ensureInitialized();
  // await InitHive().initializeHive();
  // await Purchases.configure(purchasesConfiguration);
  // await MobileAds.instance.initialize();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await HomeWidget.setAppGroupId('group.todo-planner-widget');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedDateTimeProvider()),
        ChangeNotifierProvider(create: (context) => PremiumProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ReloadProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // userBox = Hive.box('userBox');

    appTrackingTransparency();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setTheme());
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    bool isForeground = state == AppLifecycleState.resumed;
    if (isForeground) setTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  setTheme() {
    // UserBox? user = userBox?.get('userProfile');
    // String theme = user?.theme ?? tSystem;
    // Brightness brightness = MediaQuery.of(context).platformBrightness;

    // context.read<ThemeProvider>().setThemeValue(
    //       theme == tSystem
    //           ? brightness == Brightness.light
    //               ? tLight
    //               : tDark
    //           : theme,
    //     );
  }

  appTrackingTransparency() async {
    try {
      TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } on PlatformException {
      log('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ReloadProvider>().isReload;

    // UserBox? user = userBox?.get('userProfile');
    String fontFamily = 'Omyu';
    String route = 'home-page';

    return MaterialApp(
      title: 'My Weight app',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: route,
      routes: {
        'home-page': (context) => const HomePage(),
        'start-page': (context) => const StartPage()
      },
    );
  }
}
