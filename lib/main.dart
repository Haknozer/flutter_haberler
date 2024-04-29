import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/ui/homepage/home_page.dart';
import 'package:flutter_haberler/ui/onboarding/onboarding.dart';
import 'package:flutter_haberler/ui/splash/splash_screen.dart';
import 'package:flutter_haberler/ui/welcome/welcome_screen.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: ColorConstants.transparent,
        highlightColor: ColorConstants.transparent,
        hoverColor: ColorConstants.transparent,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Nuntium',
      initialRoute: '/',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const OnBoarding(),
        '/welcome': (context) => const WelcomeScreen(),
        '/homepage': (context) => const HomePage(),
      },
    );
  }
}
