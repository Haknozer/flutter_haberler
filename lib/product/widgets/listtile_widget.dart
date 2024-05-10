// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_haberler/product/constants/color_constants.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatefulWidget {
  String leadingText;

  ListTileWidget({super.key, required this.leadingText});

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        tileColor: ColorConstants.grayLighter,
        leading: Text(
          widget.leadingText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.grayDaker),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 24,
            )),
      ),
    );
  }
}
