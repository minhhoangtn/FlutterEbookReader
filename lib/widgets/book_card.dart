import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/view/details_screen.dart';
import 'package:ebook_reader/widgets/book_error_image.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({required this.entry, required this.imageUrl});

  final Entry entry;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: 140,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      entry: entry,
                    )));
          },
          child: Hero(
            tag: entry.title!.t.toString(),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor)),
                  errorWidget: (context, url, error) => BookErrorImage(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
