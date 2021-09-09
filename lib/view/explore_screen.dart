import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/models/feed.dart';
import 'package:ebook_reader/models/link.dart';
import 'package:ebook_reader/networking/api.dart';
import 'package:ebook_reader/view/genre_screen.dart';
import 'package:ebook_reader/view_models/home_provider.dart';
import 'package:ebook_reader/widgets/body_builder.dart';
import 'package:ebook_reader/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Book Collections',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
        return BodyBuilder(
          apiRequestStatus: homeProvider.apiRequestStatus,
          onPressErrorWidget: () => homeProvider.getFeedsWhenError(),
          child: ListView.builder(
              itemCount: homeProvider.top.link?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final Link link = homeProvider.top.link![index];
                if (index == 0) {
                  return Container(
                    height: 250,
                    child: Image.asset(
                      'images/explore.png',
                      fit: BoxFit.cover,
                    ),
                  );
                }
                if (index < 10) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                link.title!,
                                style: const TextStyle(fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => GenreScreen(
                                            title: link.title!,
                                            url: link.href!,
                                          ))),
                              child: Text(
                                'See more',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<Feed?>(
                          future: Api().getCategory(link.href!),
                          builder: (context, snapshot) {
                            final Feed? genreFeed = snapshot.data;
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.hasError) {
                              return Container(
                                  height: 200,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Theme.of(context).accentColor,
                                  )));
                            } else {
                              return Container(
                                height: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: genreFeed?.entry?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final Entry entry =
                                          genreFeed!.entry![index];
                                      return BookCard(
                                          entry: entry,
                                          imageUrl: entry.link![1].href!);
                                    }),
                              );
                            }
                          }),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }),
        );
      }),
    );
  }
}
