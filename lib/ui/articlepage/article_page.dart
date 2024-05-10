import 'package:flutter/material.dart';
import 'package:flutter_haberler/product/constants/color_constants.dart';
import 'package:flutter_haberler/product/constants/icon_constants.dart';
import 'package:flutter_haberler/product/widgets/appbar_widget.dart';

// ignore: must_be_immutable
class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  // ignore: prefer_typing_uninitialized_variables
  var news;
  @override
  Widget build(BuildContext context) {
    news = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: const AppBarWidget(),
      body: articleBody(context),
    );
  }

  SingleChildScrollView articleBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          articlePageHeader(),
          articlePageImage(),
          articlePageSource(context),
          articleNewsTitle(context),
          articleNews(context),
          articleNewsDetails(context),
        ],
      ),
    );
  }

  SingleChildScrollView articleNewsDetails(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          news?.description ?? "Haber İçereği Mevcut Değil",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorConstants.grayDaker),
        ),
      ),
    );
  }

  Padding articleNews(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Haber",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorConstants.blackPrimary, fontWeight: FontWeight.w600)),
    );
  }

  Padding articleNewsTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        news?.name ?? "Haber Başlığı Bulunamadı",
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: ColorConstants.blackPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding articlePageSource(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
          shape: RoundedRectangleBorder(
              side: const BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(16)),
          backgroundColor: ColorConstants.purplePrimary,
          label: Text(news?.source ?? "Haber Kaynağı Bilinmiyor",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorConstants.white))),
    );
  }

  Padding articlePageImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          news?.image ?? "https://www.cumhuriyet.com.tr/Archive/2024/4/30/2201629/kapak_142214.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Row articlePageHeader() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: ColorConstants.grayPrimary, size: 24)),
        const Spacer(),
        Image.asset(IconConstants.share.getIcon, width: 24, color: ColorConstants.grayPrimary),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.bookmark_border, color: ColorConstants.grayPrimary, size: 24))
      ],
    );
  }
}
