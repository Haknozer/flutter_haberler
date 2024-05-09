import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/image_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/button_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: const AppBarWidget(),
      body: bodyBuild(context),
    );
  }

  Center bodyBuild(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(ImageConstants.welcomehands.getImage),
          const TitleText(title: StringConstants.appName),
          const DescriptionText(
            description: StringConstants.welcomeText,
            textAlign: TextAlign.center,
          ),
          const Button(text: StringConstants.welcomeButtonText, route: "/login"),
        ],
      ),
    );
  }
}
