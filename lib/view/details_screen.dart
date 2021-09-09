import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_reader/models/book_category.dart';
import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/view_models/details_provider.dart';
import 'package:ebook_reader/view_models/pinned_provider.dart';
import 'package:ebook_reader/widgets/book_details_card.dart';
import 'package:ebook_reader/widgets/book_error_image.dart';
import 'package:ebook_reader/widgets/description_text.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final Entry entry;

  const DetailsScreen({required this.entry});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        Provider.of<DetailsProvider>(context, listen: false)
            .setEntry(widget.entry);
        Provider.of<DetailsProvider>(context, listen: false).getAuthorFeed(
            widget.entry.author!.uri!.t!.replaceAll('&lang=en', ''));
      },
    ); // to call set state during build
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DetailsProvider, PinnedProvider>(
        builder: (context, detailsProvider, pinnedProvider, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Row(
                    children: [
                      _buildBookImage(),
                      const SizedBox(width: 5),
                      _buildBookDetails(
                          context, detailsProvider, pinnedProvider),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildTitle(context, 'Book Synopsis'),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10),
                        DescriptionText(text: widget.entry.summary!.t!),
                        const SizedBox(height: 15),
                        _buildTitle(context, 'More from Author'),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                  _buildAuthorBooks(detailsProvider, context),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildAuthorBooks(
      DetailsProvider detailsProvider, BuildContext context) {
    return detailsProvider.loading
        ? Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            )),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: detailsProvider.authorFeed.entry!.length,
            itemBuilder: (BuildContext context, int index) {
              final Entry entry = detailsProvider.authorFeed.entry![index];
              return BookDetailCard(
                  entry: entry,
                  imageUrl: entry.link![1].href!,
                  title: entry.title!.t!,
                  author: entry.author!.name!.t!,
                  summary: entry.summary!.t!);
            });
  }

  Text _buildTitle(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 25, color: Theme.of(context).accentColor),
    );
  }

  Flexible _buildBookDetails(BuildContext context,
      DetailsProvider detailsProvider, PinnedProvider pinnedProvider) {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.only(top: 40, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: widget.entry.title!.t,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            maxLines: 2,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.entry.author!.name!.t!,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w800, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.entry.category == null)
            const SizedBox()
          else
            SizedBox(
              height: widget.entry.category!.length < 3 ? 50 : 90,
              child: GridView.builder(
                  itemCount: widget.entry.category!.length > 4
                      ? 4
                      : widget.entry.category!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final BookCategory category = widget.entry.category![index];
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Theme.of(context).accentColor)),
                        child: Center(
                            child: Text(
                          category.label!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: category.label!.length > 12 ? 9 : 14),
                        )));
                  }),
            ),
          Text(
            'Published: ${widget.entry.dctermsIssued!.t!} (${widget.entry.dctermsLanguage!.t!.toUpperCase()})',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    if (detailsProvider.downloaded) {
                      EpubViewer.setConfig(
                        identifier: 'books',
                        themeColor: Theme.of(context).accentColor,
                        scrollDirection: EpubScrollDirection.VERTICAL,
                        nightMode: true,
                        allowSharing: true,
                      );
                      final String bookPath =
                          await detailsProvider.getBookPath();
                      EpubViewer.open(bookPath);
                    } else {
                      detailsProvider.downloadFile(
                          context,
                          widget.entry.link![3].href!,
                          widget.entry.title!.t!
                              .replaceAll(' ', '_')
                              .replaceAll(':', '_'));
                    }
                  },
                  icon: Icon(
                    Icons.book_outlined,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    detailsProvider.downloaded ? 'Read book' : 'Get this book',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: const CircleBorder()),
                          onPressed: () {},
                          child: IconButton(
                            onPressed: () async {
                              if (detailsProvider.pinned) {
                                detailsProvider.removePinned();
                                await pinnedProvider.getPinnedList();
                              } else {
                                detailsProvider.addPinned();
                                await pinnedProvider.getPinnedList();
                              }
                            },
                            icon: detailsProvider.pinned
                                ? const Icon(Icons.grade)
                                : const Icon(Icons.star_border_outlined),
                            color: detailsProvider.pinned
                                ? Colors.yellow
                                : Theme.of(context).accentColor,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: const CircleBorder()),
                          onPressed: () {},
                          child: Icon(
                            Icons.share_outlined,
                            color: Theme.of(context).accentColor,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Flexible _buildBookImage() {
    return Flexible(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 25),
        child: Hero(
          tag: widget.entry.title!.t.toString(),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: widget.entry.link![1].href!,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor)),
                errorWidget: (context, url, error) => BookErrorImage(),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
