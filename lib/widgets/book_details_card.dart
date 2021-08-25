import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/view/details_screen.dart';
import 'package:ebook_reader/widgets/book_error_image.dart';
import 'package:flutter/material.dart';

class BookDetailCard extends StatelessWidget {
  const BookDetailCard(
      {required this.entry,
      required this.imageUrl,
      required this.title,
      required this.author,
      required this.summary});

  final Entry entry;
  final String imageUrl;
  final String title;
  final String author;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  entry: entry,
                )));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Container(
          height: 160,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: 130,
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
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: title,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      author,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(height: 10),
                    Text(
                      summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
