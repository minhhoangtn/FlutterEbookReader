import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/view_models/genre_provider.dart';
import 'package:ebook_reader/widgets/body_builder.dart';
import 'package:ebook_reader/widgets/book_details_card.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class GenreScreen extends StatefulWidget {
  final String title;
  final String url;

  GenreScreen({required this.title, required this.url});

  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<GenreProvider>(context, listen: false).getFeeds(widget.url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Consumer<GenreProvider>(
        builder: (context, genreProvider, child) {
          return BodyBuilder(
            apiRequestStatus: genreProvider.apiRequestStatus,
            onPressErrorWidget: () => genreProvider.getFeeds(widget.url),
            child: ListView(
              controller: genreProvider.scrollController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: genreProvider.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    Entry entry = genreProvider.items[index];
                    if (index == genreProvider.items.length)
                      return CircularProgressIndicator();
                    return BookDetailCard(
                        entry: entry,
                        imageUrl: entry.link![1].href!,
                        title: entry.title!.t!,
                        author: entry.author!.name!.t!,
                        summary: entry.summary!.t!);
                  },
                ),
                SizedBox(height: 10),
                genreProvider.isLoading
                    ? Container(
                        height: 80,
                        width: 30,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor,
                        )),
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
