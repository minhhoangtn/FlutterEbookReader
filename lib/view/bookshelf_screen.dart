import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_reader/models/download_helper.dart';
import 'package:ebook_reader/widgets/book_error_image.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';

class BookshelfScreen extends StatefulWidget {
  @override
  _BookshelfScreenState createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
  List downloadList = [];
  bool _editMode = false;
  bool _isLoading = false;

  Future<void> getDownloadList() async {
    downloadList.clear();
    setState(() {
      _isLoading = true;
    });
    List<Map<String, Object?>> list =
        await DownloadDB.queryAll('download_books');
    setState(() {
      downloadList.addAll(list);
      _isLoading = false;
    });
  }

  Future<void> removeDownloadItem(String id, String path) async {
    await DownloadDB.delete('download_books', id);
    File bookFile = File(path);
    if (await bookFile.exists()) bookFile.delete();

    setState(() {
      downloadList.removeWhere((element) => element['id'] == id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDownloadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My BookShelf',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  _editMode = !_editMode;
                });
              },
              child: Text(
                _editMode ? 'Done' : 'Edit',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 18),
              ))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            )
          : (downloadList.isEmpty ? _buildEmpty() : _buildBookShelf()),
    );
  }

  _buildBookShelf() {
    return GridView.builder(
        itemCount: downloadList.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 200 / 365,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      EpubViewer.setConfig(
                        identifier: 'books',
                        themeColor: Theme.of(context).accentColor,
                        scrollDirection: EpubScrollDirection.VERTICAL,
                        nightMode: true,
                        enableTts: false,
                        allowSharing: true,
                      );
                      EpubViewer.open(downloadList[index]['path']);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          height: 150,
                          width: 100,
                          imageUrl: downloadList[index]['imageUrl'],
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).accentColor)),
                          errorWidget: (context, url, error) =>
                              BookErrorImage(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: _editMode ? 1.0 : 0.0,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: ElevatedButton(
                        child: Icon(
                          Icons.remove,
                          size: 15,
                        ),
                        onPressed: () {
                          if (_editMode) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      content: Text(
                                        'Delete this book ?',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await removeDownloadItem(
                                                  downloadList[index]['id'],
                                                  downloadList[index]['path']);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 16),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 16),
                                            )),
                                      ],
                                    ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          primary: Colors.red,
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                downloadList[index]['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )
            ],
          );
        });
  }

  _buildEmpty() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 300,
          child: Image.asset(
            'images/empty.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 300,
          child: Text(
            'There is nothing here, please add some books to your shelf 😩',
            style: TextStyle(fontSize: 20),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}
