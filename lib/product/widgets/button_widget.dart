// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class Button extends StatelessWidget {
  final String text;
  final String route;

  const Button({
    super.key,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, route);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(ColorConstants.purplePrimary),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
