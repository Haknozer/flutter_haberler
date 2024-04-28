// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class DescriptionText extends StatelessWidget {
  final String description;
  const DescriptionText({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: ColorConstants.grayPrimary,
          ),
      textAlign: TextAlign.center,
    );
  }
}
