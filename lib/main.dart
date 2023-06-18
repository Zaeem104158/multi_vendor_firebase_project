import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/l10n/l10n.dart';
import 'package:firebase_multi_vendor_project/practice.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/cart_provider/cart_provider.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_multi_vendor_project/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'views/provider/wishlist_provider/wishlist_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UiProvider uiProvider = UiProvider();
  await uiProvider.loadThemeMode();
  await uiProvider.loadLocalMode();
  // Loading a provider then return it in changenotifier.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) {
          return AuthController();
        },
      ),
      ChangeNotifierProvider<UiProvider>.value(value: uiProvider),
      ChangeNotifierProvider(
        create: (context) {
          return CartProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return WishListProvider();
        },
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Consumer<UiProvider>(builder: (context, uiProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: uiProvider.locale,
            supportedLocales: L10n.all,
            // initialRoute: Page1.page1Name,
            // routes: {
            //   Page1.page1Name: (context) => Page1(),
            //   // Page2.page2Name: (context) => Page2(),
            //   // Page3.page3Name: (context) => Page3(),
            // },
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            title: 'Flutter Demo',
            builder: EasyLoading.init(),
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  counterStyle: TextStyle(
                      color: blackColor, fontWeight: regularBoldFontWeight)),
              fontFamily: 'RobotoMono',
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: uiProvider.themeMode == ThemeModeType.light
                ? ThemeMode.light
                : ThemeMode.dark,
            home: SplashScreen());
      }),
    );
  }
}
