import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/icon_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
}
