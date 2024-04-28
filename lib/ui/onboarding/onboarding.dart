import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/image_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/widgets/button_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBuild(context),
    );
  }

  Center bodyBuild(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Image.asset(ImageConstants.onboardbuild.getImage),
      const TitleText(title: StringConstants.onBoardTitle),
      const DescriptionText(description: StringConstants.onBoardText),
      const Button(text: StringConstants.onBoardButtonText, route: '/welcome'),
    ]));
  }
}
