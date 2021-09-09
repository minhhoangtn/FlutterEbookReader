import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:ebook_reader/models/feed.dart';

import 'package:xml2json/xml2json.dart';

class Api {
  static String publicDomainUrl =
      'https://catalog.feedbooks.com/publicdomain/browse';
  static String popularUrl = '$publicDomainUrl/top.atom';
  static String recentUrl = '$publicDomainUrl/recent.atom';

  Future<Feed> getCategory(String url) async {
    final res = await Dio().get(url).catchError((e) {
      throw e as DioError;
    });

    Feed category;

    if (res.statusCode == 200) {
      final xml2json = Xml2Json();
      xml2json.parse(res.data.toString());
      final json = jsonDecode(xml2json.toGData());
      category = Feed.fromJson(json['feed'] as Map<String, dynamic>);
    } else {
      throw 'error ${res.statusCode}';
    }

    return category;
  }
}
