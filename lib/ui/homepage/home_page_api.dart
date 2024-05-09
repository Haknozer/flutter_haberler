// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter_haberler/product/model/news_model.dart';
import 'package:http/http.dart' as http;

//https://api.collectapi.com/news/getNewsfromRSS?data.rss_url=http%3A%2F%2Fwww.webrazzi.com%2Ffeed%2F
//https://api.collectapi.com/news/getNews?country=tr&tag=politics
class HomePageNewsService {
  late List<News> newsList;
  Future<List<News>> getNews(String tag) async {
    String newsUrl = "https://api.collectapi.com/news/getNews?country=tr&tag=$tag";
    final response = await http.get(Uri.parse(newsUrl), headers: {
      'authorization': 'apikey 7yWmE60yUxRUoAkP02Lc8T:22JAM6Fu31siGkcrBMOEkI',
      'content-type': 'application/json',
    });

    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final newsModel = jsonDecode(response.body);
        newsList = newsModel['result'].map((e) => News.fromJson(e as Map<String, dynamic>)).toList().cast<News>();
        return newsList;
      default:
        return Future.error(response.statusCode);
    }
  }
}

// general
// sport
// economy
// technology
// health
// world
// magazine
