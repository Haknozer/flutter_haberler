// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class DescriptionText extends StatelessWidget {
  final String description;
  final TextAlign textAlign;
  const DescriptionText({
    super.key,
    required this.description,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: ColorConstants.grayPrimary,
          ),
      textAlign: textAlign,
    );
  }
}
