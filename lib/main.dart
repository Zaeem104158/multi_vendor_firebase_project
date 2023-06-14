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
        return CartProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return WishListProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return UiProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return AuthController();
      },
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthController authController = AuthController();
  // This widget is the root of your application

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        theme: ThemeData(
          colorScheme:
              ColorScheme.light(onBackground: blueGreyColor.withOpacity(0.5)),
          // bottomSheetTheme: BottomSheetThemeData(
          //     backgroundColor: blueGreyColor.withOpacity(0.5)),
          inputDecorationTheme: InputDecorationTheme(
              counterStyle: TextStyle(
                  color: blackColor, fontWeight: regularBoldFontWeight)),
          fontFamily: 'RobotoMono',
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
