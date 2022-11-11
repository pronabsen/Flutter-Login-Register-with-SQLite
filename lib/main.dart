import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management/screens/splash_screen.dart';
import 'package:library_management/store/AppStore.dart';
import 'package:library_management/utils/AppTheme.dart';
import 'package:library_management/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

AppStore appStore = AppStore();

void main() async {
//  _sharedPreferences = await SharedPreferences.getInstance();

  //region Entry Point
  //WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = STRIPE_PAYMENT_PUBLISH_KEY;
  // appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));
  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(MyApp());
  //endregion
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
      home: const SplashScreen(),
    );
  }
}

