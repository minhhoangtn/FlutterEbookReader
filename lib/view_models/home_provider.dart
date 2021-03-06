import 'package:ebook_reader/enum/api_request_status.dart';
import 'package:ebook_reader/models/feed.dart';
import 'package:ebook_reader/networking/api.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  Feed top = Feed();
  Feed recent = Feed();
  final api = Api();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;

  Future<void> getFeeds() async {
    try {
      final Feed popular = await api.getCategory(Api.popularUrl);
      setTop(popular);
      final Feed newRelease = await api.getCategory(Api.recentUrl);
      setRecent(newRelease);
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  Future<void> getFeedsWhenError() async {
    try {
      setApiRequestStatus(APIRequestStatus.loading);
      final Feed popular = await api.getCategory(Api.popularUrl);
      setTop(popular);
      final Feed newRelease = await api.getCategory(Api.recentUrl);
      setRecent(newRelease);
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setTop(Feed value) {
    top = value;
    notifyListeners();
  }

  void setRecent(Feed value) {
    recent = value;
    notifyListeners();
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
