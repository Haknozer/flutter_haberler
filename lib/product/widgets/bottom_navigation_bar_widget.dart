// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_haberler/product/constants/color_constants.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatefulWidget {
  int selectedIndex = 0;

  BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  List pages = ["homepage", "categories", "bookmarks", "profile"];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: ColorConstants.purplePrimary,
      unselectedItemColor: ColorConstants.grayLight,
      iconSize: 25,
      showSelectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "null"),
        BottomNavigationBarItem(icon: Icon(Icons.window_sharp), label: "null"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: "null"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "null"),
      ],
      currentIndex: widget.selectedIndex,
      onTap: (value) {
        setState(() {
          widget.selectedIndex != value ? Navigator.popAndPushNamed(context, "/${pages[value]}") : null;
          widget.selectedIndex = value;
        });
      },
    );
  }
}
