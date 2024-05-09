// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/model/categories_model.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String tag = "";
  List<IconData> categoriesIcon = [
    Icons.newspaper_outlined,
    Icons.sports_football_outlined,
    Icons.money_outlined,
    Icons.computer_outlined,
    Icons.health_and_safety_outlined,
    Icons.airplanemode_on_outlined,
    Icons.star_border_outlined,
  ];
  late Categories categories;
  @override
  void initState() {
    super.initState();
    categories = Categories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: body(),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: 1,
      ),
    );
  }

  Padding body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(title: StringConstants.categoriesTitle),
          const DescriptionText(description: StringConstants.categoriesText),
          categoriesBuilder()
        ],
      ),
    );
  }

  Expanded categoriesBuilder() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: categories.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var categori = snapshot.data;
              return gridviewBuilder(categori);
            } else {
              return const LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  GridView gridviewBuilder(List<String>? categori) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: categori!.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, childAspectRatio: 2),
      itemBuilder: (context, index) {
        return chipBuilder(index, categori, context);
      },
    );
  }

  InkWell chipBuilder(int index, List<String> categori, BuildContext context) {
    return InkWell(
      onTap: () {
        tag = categori[index];
        Navigator.popAndPushNamed(context, '/categorieshomepage', arguments: tag);
      },
      child: Chip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), side: const BorderSide(color: ColorConstants.grayLighter)),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Icon(categoriesIcon[index], color: ColorConstants.purplePrimary),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Text(
                  categori[index],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          )),
    );
  }
}
