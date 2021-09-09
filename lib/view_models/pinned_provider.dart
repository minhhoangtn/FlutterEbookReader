import 'package:ebook_reader/models/pinned_helper.dart';
import 'package:flutter/material.dart';

class PinnedProvider with ChangeNotifier {
  List pinnedList = [];

  Future<void> getPinnedList() async {
    pinnedList.clear();
    final List<Map<String, Object?>> list =
        await PinnedDB.queryAll('favorite_books');
    pinnedList.addAll(list);
    notifyListeners();
  }

  Future<void> removePinnedItem(String id) async {
    await PinnedDB.delete('favorite_books', id);
    pinnedList.removeWhere((element) => element['id'] == id);
    notifyListeners();
  }
}
