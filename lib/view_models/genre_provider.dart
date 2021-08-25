import 'dart:async';

import 'package:ebook_reader/enum/api_request_status.dart';
import 'package:ebook_reader/models/feed.dart';
import 'package:ebook_reader/networking/api.dart';
import 'package:flutter/material.dart';

class GenreProvider with ChangeNotifier {
  List items = [];
  ScrollController scrollController = ScrollController();
  final api = Api();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;

  int page = 1;
  bool isLoading = false;
  bool pageRemaining = true;

  Future<void> getFeeds(String url) async {
    scrollController.removeListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadNextPage(url);
      }
    });
    scrollController.dispose();
    scrollController = ScrollController();

    pageRemaining = true;
    page = 1;

    notifyListeners();
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      Feed firstFeed = await api.getCategory(url);
      items = firstFeed.entry!;
      addControllerListener(url);
      notifyListeners();
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      print(e);
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void addControllerListener(String url) {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadNextPage(url);
      }
    });
  }

  Future<void> loadNextPage(String url) async {
    if (apiRequestStatus != APIRequestStatus.loading &&
        !isLoading &&
        pageRemaining) {
      Timer(Duration(milliseconds: 100), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.linear);
      });
      //jump to bottom of list
      isLoading = true;
      page = page + 1;
      notifyListeners();
      print(page);
      print(url);

      Feed nextFeed = await api.getCategory(url + '&page=$page');
      if (nextFeed.entry?[0] == null) {
        pageRemaining = false;
        isLoading = false;
        notifyListeners();
      } else {
        items.addAll(nextFeed.entry!);
        isLoading = false;
        notifyListeners();
      }
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
