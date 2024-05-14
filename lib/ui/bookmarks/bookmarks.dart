import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/string_constants.dart';
import 'package:flutter_haberler/product/model/news_model.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';
import 'package:flutter_haberler/product/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/description_text_widget.dart';
import 'package:flutter_haberler/product/widgets/text_widgets/title_text_widget.dart';
import 'package:flutter_haberler/ui/bookmarks/bookmarks_firebase.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  late BookmarkFirestoreDatabase bookmarks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookmarks = BookmarkFirestoreDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: body(),
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: 2),
    );
  }

  Padding body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(title: StringConstants.bookmarksTitle),
          const DescriptionText(description: StringConstants.bookmarksText),
          futureBuilderBuild()
        ],
      ),
    );
  }

  FutureBuilder<List<News>> futureBuilderBuild() {
    return FutureBuilder(
      future: bookmarks.getBookmarksNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: listViewBuild(snapshot),
          );
        } else {
          return noBookmarking(context);
        }
      },
    );
  }

  Column noBookmarking(BuildContext context) {
    return Column(
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
    );
  }

  ListView listViewBuild(AsyncSnapshot<List<News>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var news = snapshot.data;
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/articlepage", arguments: news?[index]);
          },
          child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  bookmarks.deleteBookmarksNews(news![index].name.toString());
                });
              },
              child: listTile(news, index, context)),
        );
      },
    );
  }

  ListTile listTile(List<News>? news, int index, BuildContext context) {
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
}
