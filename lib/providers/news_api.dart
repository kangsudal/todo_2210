import 'dart:convert';

import 'package:todo_sqlite/models/news.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  static String apiUri = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=';
  static String apiKey = '6c9e5c073d74420cab30ff0df9c5368c';

  Uri uri = Uri.parse(apiUri +apiKey);

  Future<List<News>> getNews() async{
    List<News> news = [];
    final response = await http.get(uri);
    final statusCode = response.statusCode;
    final body = response.body;

    if(statusCode == 200){
      news = jsonDecode(body)['articles'].map<News>((article){
        return News.fromMap(article);
      }).toList();
    }
    return news;
  }
}