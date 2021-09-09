import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/models/link.dart';
import 'package:ebook_reader/view/genre_screen.dart';
import 'package:ebook_reader/view_models/home_provider.dart';
import 'package:ebook_reader/widgets/body_builder.dart';
import 'package:ebook_reader/widgets/book_card.dart';
import 'package:ebook_reader/widgets/book_details_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<HomeProvider>(context, listen: false).getFeeds(),
        builder: (ctx, snapshot) {
          return Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
            return _buildBodyBuilder(homeProvider, context);
          });
        });
  }

  Scaffold _buildBodyBuilder(HomeProvider homeProvider, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/logo_feedbooks.png',
          width: 160,
          height: 40,
        ),
      ),
      body: BodyBuilder(
        apiRequestStatus: homeProvider.apiRequestStatus,
        onPressErrorWidget: () => homeProvider.getFeedsWhenError(),
        child: RefreshIndicator(
          color: Theme.of(context).accentColor,
          onRefresh: () {
            return homeProvider.getFeedsWhenError();
          },
          child: _buildBodyChild(homeProvider),
        ),
      ),
    );
  }

  ListView _buildBodyChild(HomeProvider homeProvider) {
    return ListView(children: [
      const SizedBox(height: 20),
      _buildTitle('Best Selling'),
      const SizedBox(height: 20),
      _buildPopularBook(homeProvider),
      const SizedBox(height: 20),
      _buildTitle('Categories'),
      const SizedBox(height: 10),
      _buildGenres(homeProvider),
      const SizedBox(height: 20),
      _buildTitle('Recently Added'),
      const SizedBox(height: 15),
      _buildNewRelease(homeProvider),
    ]);
  }

  ListView _buildNewRelease(HomeProvider homeProvider) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeProvider.recent.entry?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final Entry entry = homeProvider.recent.entry![index];
          return BookDetailCard(
            entry: entry,
            imageUrl: entry.link![1].href!,
            title: entry.title!.t!,
            author: entry.author!.name!.t!,
            summary: entry.summary!.t!,
          );
        });
  }

  Container _buildGenres(HomeProvider homeProvider) {
    return Container(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: homeProvider.top.link?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final Link link = homeProvider.top.link![index];
          if (index < 10) return const SizedBox();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          GenreScreen(title: link.title!, url: link.href!)));
                },
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    link.title!,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 23),
          )
        ],
      ),
    );
  }

  Container _buildPopularBook(HomeProvider homeProvider) {
    return Container(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: homeProvider.top.entry?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final Entry entry = homeProvider.top.entry![index];
          return BookCard(
            entry: entry,
            imageUrl: entry.link![1].href!,
          );
        },
      ),
    );
  }
}
