import 'dart:convert';
import 'dart:io';

import 'package:ebook_reader/models/download_helper.dart';
import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/models/pinned_helper.dart';
import 'package:ebook_reader/models/feed.dart';
import 'package:ebook_reader/networking/api.dart';
import 'package:ebook_reader/widgets/download_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class DetailsProvider with ChangeNotifier {
  Feed authorFeed = Feed();
  Entry entry = Entry();
  final api = Api();

  bool pinned = false;
  bool loading = true;
  bool downloaded = false;

  Future<void> getAuthorFeed(String url) async {
    try {
      setLoading(true);
      checkPinned();
      checkDownload();
      final Feed relatedBook = await api.getCategory(url);
      setAuthorFeed(relatedBook);
      setLoading(false);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkPinned() async {
    await PinnedDB.check('favorite_books', entry.id!.t!.toString())
        ? setFav(true)
        : setFav(false);
  }

  Future<void> addPinned() async {
    await PinnedDB.insert('favorite_books', {
      'id': entry.id!.t!.toString(),
      'entry': jsonEncode(entry.toJson()),
      // 'entry': entry.toJson().toString(),
    });
    checkPinned();
  }

  Future<void> removePinned() async {
    await PinnedDB.delete('favorite_books', entry.id!.t!.toString());
    checkPinned();
  }

  Future<String> getBookPath() async {
    final Object? bookPath =
        await DownloadDB.getBookPath('download_books', entry.id!.t!.toString());
    return bookPath.toString();
  }

  Future<void> checkDownload() async {
    final Object? bookPath =
        await DownloadDB.getBookPath('download_books', entry.id!.t!.toString());

    if (bookPath != null && await File(bookPath.toString()).exists()) {
      setDownload(true);
    } else {
      setDownload(false);
      await DownloadDB.delete('download_books', entry.id!.t!.toString());
    }
  }

  Future<void> addDownload(Map<String, Object> data) async {
    await DownloadDB.insert('download_books', data);
    checkDownload();
  }

  Future<void> downloadFile(
      BuildContext context, String url, String bookName) async {
    final PermissionStatus status = await Permission.storage.request();
    final PermissionStatus status1 =
        await Permission.manageExternalStorage.request();

    if (status.isGranted || status1.isGranted) {
      final appDirectory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      if (appDirectory == null) return;

      final String externalStoragePath = appDirectory.path.split('Android')[0];
      if (Platform.isAndroid) {
        Directory(path.join(externalStoragePath, 'EbookReaderFlutter'))
            .createSync();
      } //create file folder in external storage Android

      final String bookPath = Platform.isAndroid
          ? path.join(
              externalStoragePath, 'EbookReaderFlutter', '$bookName.epub')
          : path.join(appDirectory.path, '$bookName.epub');

      Future.delayed(Duration.zero).then((value) => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) =>
                  DownloadDialog(url: url, appPath: bookPath)).then((value) {
            if (value != null) {
              addDownload({
                'id': entry.id!.t!.toString(),
                'path': bookPath,
                'size': value as int,
                'imageUrl': entry.link![1].href!.toString(),
                'title': entry.title!.t!.toString(),
                'author': entry.author!.name!.t!.toString(),
              });
            }
          }));
    }
  }

  void setAuthorFeed(Feed value) {
    authorFeed = value;
    notifyListeners();
  }

  void setEntry(Entry value) {
    entry = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setFav(bool value) {
    pinned = value;
    notifyListeners();
  }

  void setDownload(bool value) {
    downloaded = value;
    notifyListeners();
  }
}
