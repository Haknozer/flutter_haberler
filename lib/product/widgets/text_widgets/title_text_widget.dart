import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: ColorConstants.blackPrimary, fontWeight: FontWeight.bold),
    );
  }
}
