import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/cart_provider/cart_provider.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_multi_vendor_project/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'views/provider/wishlist_provider/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) => print("Firebase Initialized Completed"));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) {
        return AuthController();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return UiProvider();
      },
    ),
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
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UiProvider uiProvider =
        Provider.of<UiProvider>(context, listen: true);
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        theme: uiProvider.currentThemeMode == ThemeMode.light
            ? ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                    counterStyle: TextStyle(
                        color: blackColor, fontWeight: regularBoldFontWeight)),
                fontFamily: 'RobotoMono',
                primarySwatch: Colors.blue,
              )
            : ThemeData.dark(),
        home: SplashScreen(),
      ),
    );
  }
}
