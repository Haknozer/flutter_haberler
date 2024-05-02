import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/icon_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/ui/splash/splash_current_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = SplashScrennCurrentUser().currentUser();
    print(user);
    navigatorPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purplePrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconConstants.applogo.getIcon),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: animatedTextKitBuild(context),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedTextKit animatedTextKitBuild(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        WavyAnimatedText(StringConstants.appName,
            textStyle: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: ColorConstants.white, fontWeight: FontWeight.bold)),
      ],
      isRepeatingAnimation: true,
    );
  }

  navigatorPage() {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        user == true
            ? Navigator.popAndPushNamed(context, "/homepage")
            : Navigator.popAndPushNamed(context, "onbarding");
      },
    );
  }
}
