import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/model/news_model.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';
import 'package:flutter_haberler/ui/homepage/home_page_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late HomePageNewsService homePageNewsService;
  @override
  void initState() {
    super.initState();
    homePageNewsService = HomePageNewsService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(title: StringConstants.homePageTitle),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: DescriptionText(description: StringConstants.homePageDescription),
            ),
            Expanded(child: futureBuilderBuild()),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<News>> futureBuilderBuild() {
    return FutureBuilder(
      future: homePageNewsService.getNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return listViewBuild(snapshot);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListView listViewBuild(AsyncSnapshot<List<News>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var news = snapshot.data;
        return const Center();
      },
    );
  }
}
