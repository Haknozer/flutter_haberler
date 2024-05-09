import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_haberler/firebase_options.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/model/shared_preferences.dart';
import 'package:flutter_haberler/ui/articlepage/article_page.dart';
import 'package:flutter_haberler/ui/categories/categories.dart';
import 'package:flutter_haberler/ui/categorieshomepage/categories_home_page.dart';
import 'package:flutter_haberler/ui/homepage/home_page.dart';
import 'package:flutter_haberler/ui/login/login.dart';
import 'package:flutter_haberler/ui/onboarding/onboarding.dart';
import 'package:flutter_haberler/ui/splash/splash_screen.dart';
import 'package:flutter_haberler/ui/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  await SharedInit.instance.sharedSetup();
  runApp(const MyApp());
}

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
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoarding(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/homepage': (context) => const HomePage(),
        '/articlepage': (context) => const ArticlePage(),
        '/categories': (context) => const CategoriesPage(),
        '/categorieshomepage': (context) => const CategoriesHomePage(),
      },
    );
  }
}
