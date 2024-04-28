import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

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
