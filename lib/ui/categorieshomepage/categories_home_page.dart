import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/model/news_model.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';
import 'package:flutter_haberler/ui/homepage/home_page_api.dart';

class CategoriesHomePage extends StatefulWidget {
  const CategoriesHomePage({super.key});

  @override
  State<CategoriesHomePage> createState() => _CategoriesHomePageState();
}

class _CategoriesHomePageState extends State<CategoriesHomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var tag;
  late HomePageNewsService homePageNewsService;
  @override
  void initState() {
    super.initState();
    homePageNewsService = HomePageNewsService();
  }

  @override
  Widget build(BuildContext context) {
    tag = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: const AppBarWidget(),
      body: body(),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 0),
    );
  }

  Padding body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(title: StringConstants.homePageTitle),
          const DescriptionText(description: StringConstants.homePageDescription),
          futureBuilderBuild()
        ],
      ),
    );
  }

  Expanded futureBuilderBuild() {
    return Expanded(
      child: FutureBuilder(
        future: homePageNewsService.getNews(tag),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listViewBuild(snapshot);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  SizedBox listViewBuild(AsyncSnapshot<List<News>> snapshot) {
    return SizedBox(
      height: 175,
      child: ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          var news = snapshot.data;
          return stackBuild(news, index, context);
        },
      ),
    );
  }

  Padding stackBuild(List<News>? news, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/articlepage', arguments: news[index]);
        },
        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(news![index].image ?? "")),
            newsTextBuild(news, index, context),
          ],
        ),
      ),
    );
  }

  Positioned newsTextBuild(List<News> news, int index, BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: 75,
        color: ColorConstants.grayLighter,
        child: Column(
          children: [
            Text(
              news[index].name!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.blackPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
