import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/model/categories_model.dart';
import 'package:flutter_haberler/product/model/news_model.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';
import 'package:flutter_haberler/ui/bookmarks/bookmarks_firebase.dart';
import 'package:flutter_haberler/ui/homepage/home_page_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

int chipSelectedNumber = 0;

class _HomePage extends State<HomePage> {
  String tag = "general";
  late HomePageNewsService homePageNewsService;
  late BookmarkFirestoreDatabase bookmarkFirestoreDatabase;
  late Categories categories;
  @override
  void initState() {
    super.initState();
    homePageNewsService = HomePageNewsService();
    categories = Categories();
    bookmarkFirestoreDatabase = BookmarkFirestoreDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: body(context),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 0),
    );
  }

  Padding body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(), // başlık
          Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: categoriesBuild()), // kategoriler
          futureBuilderBuild(), // haberler
          Padding(padding: const EdgeInsets.only(top: 30, bottom: 10), child: recommendedText(context)),
          recommendedNews(),
        ],
      ),
    );
  }

  FutureBuilder<List<News>> recommendedNews() {
    return FutureBuilder(
      future: bookmarkFirestoreDatabase.getBookmarksNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return bookmarkingListView(snapshot);
        } else {
          return noBookmarking(context);
        }
      },
    );
  }

  ListView bookmarkingListView(AsyncSnapshot<List<News>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var news = snapshot.data;
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Image.network(
              news![index].image ?? "",
              fit: BoxFit.cover,
            ),
          ),
          title: listTileTitle(news, index, context),
          subtitle: listTileSubTitle(news, index, context),
        );
      },
    );
  }

  Expanded noBookmarking(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          maxRadius: 36,
          backgroundColor: ColorConstants.antiFlashWhite,
          child: Icon(
            Icons.menu_book_outlined,
            size: 24,
            color: ColorConstants.veryLightBlue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 12),
          child: Text(StringConstants.bookmarksNoBookmarking,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.blackPrimary)),
        )
      ],
    ));
  }

  Text listTileSubTitle(List<News> news, int index, BuildContext context) {
    return Text(
      news[index].name!,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.blackPrimary),
    );
  }

  Text listTileTitle(List<News> news, int index, BuildContext context) {
    return Text(
      news[index].source!,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorConstants.grayPrimary),
    );
  }

  Row recommendedText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          StringConstants.homePageRecommended,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorConstants.blackPrimary),
        ),
        Text(
          StringConstants.homePageSeeAll,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorConstants.grayPrimary),
        ),
      ],
    );
  }

  FutureBuilder<List<String>> categoriesBuild() {
    return FutureBuilder(
      future: categories.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var categori = snapshot.data;
          return SizedBox(
            height: 50,
            child: categoriesListView(categori),
          );
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }

  ListView categoriesListView(List<String>? categori) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categori!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              chipSelectedNumber = index;
              tag = categori[index];
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: categoriesListViewChip(categori, index, context),
          ),
        );
      },
    );
  }

  Chip categoriesListViewChip(List<String> categori, int index, BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
          side: const BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(26)),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      label: Text(
        categori[index],
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: chipSelectedNumber == index ? ColorConstants.white : ColorConstants.grayPrimary,
            ),
      ),
      backgroundColor: chipSelectedNumber == index ? ColorConstants.purplePrimary : ColorConstants.grayLighter,
    );
  }

  Column header() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(title: StringConstants.homePageTitle),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: DescriptionText(
            description: StringConstants.homePageDescription,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  FutureBuilder<List<News>> futureBuilderBuild() {
    return FutureBuilder(
      future: homePageNewsService.getNews(tag),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(height: 175, child: listViewBuild(snapshot));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListView listViewBuild(AsyncSnapshot<List<News>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var news = snapshot.data;
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/articlepage',
              arguments: news[index],
            );
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 12),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      news![index].image ?? "",
                    )),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      newsBookmark(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: newsTitle(news, index, context),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  IconButton newsBookmark() {
    return IconButton(
        alignment: Alignment.topRight,
        onPressed: () {},
        icon: const Icon(
          Icons.bookmark_border,
          color: ColorConstants.white,
          size: 30,
        ));
  }

  Column newsTitle(List<News> news, int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news[index].source ?? "",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorConstants.grayLighter),
        ),
        Text(
          news[index].name ?? "",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorConstants.white, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
