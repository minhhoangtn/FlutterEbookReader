import 'package:ebook_reader/models/book_author.dart';
import 'package:ebook_reader/models/book_category.dart';
import 'package:ebook_reader/models/book_link.dart';
import 'package:ebook_reader/models/book_schema_series.dart';
import 'package:ebook_reader/models/id.dart';

class Entry {
  Id? title;
  Id? id;
  BookAuthor? author;
  Id? published;
  Id? updated;
  Id? dctermsLanguage;
  Id? dctermsPublisher;
  Id? dctermsIssued;
  Id? summary;
  List<BookCategory>? category;
  List<BookLink>? link;
  BookSchemaSeries? schemaSeries;

  Entry({
    this.title,
    this.id,
    this.author,
    this.published,
    this.updated,
    this.dctermsIssued,
    this.dctermsLanguage,
    this.dctermsPublisher,
    this.schemaSeries,
    this.summary,
    this.category,
    this.link,
  });

  Entry.fromJson(Map<String, dynamic> json) {
    title = json['title'] == null
        ? null
        : Id.fromJson(json['title'] as Map<String, dynamic>);

    id = json['id'] == null
        ? null
        : Id.fromJson(json['id'] as Map<String, dynamic>);

    if (json['author'].runtimeType.toString() == 'List<dynamic>') {
      author = (json['author'] == null)
          ? null
          : BookAuthor.fromJsonList(json['author'] as List<dynamic>);
    } else {
      author = json['author'] == null
          ? null
          : BookAuthor.fromJson(json['author'] as Map<String, dynamic>);
    }

    published = json['published'] == null
        ? null
        : Id.fromJson(json['published'] as Map<String, dynamic>);

    updated = json['updated'] == null
        ? null
        : Id.fromJson(json['updated'] as Map<String, dynamic>);

    dctermsLanguage = json['dcterms\$language'] == null
        ? null
        : Id.fromJson(json['dcterms\$language'] as Map<String, dynamic>);

    dctermsPublisher = json['dcterms\$publisher'] == null
        ? null
        : Id.fromJson(json['dcterms\$publisher'] as Map<String, dynamic>);

    dctermsIssued = json['dcterms\$issued'] == null
        ? null
        : Id.fromJson(json['dcterms\$issued'] as Map<String, dynamic>);

    summary = json['summary'] == null
        ? null
        : Id.fromJson(json['summary'] as Map<String, dynamic>);

    if (json['category'] != null) {
      final String t = json['category'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        category = [];
        json['category'].forEach((v) {
          category?.add(BookCategory.fromJson(v as Map<String, dynamic>));
        });
      } else {
        category = [];
        category?.add(
            BookCategory.fromJson(json['category'] as Map<String, dynamic>));
      }
    }

    if (json['link'] != null) {
      final String t = json['link'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        link = [];
        json['link'].forEach((v) {
          link?.add(BookLink.fromJson(v as Map<String, dynamic>));
        });
      } else {
        link = [];
        link?.add(BookLink.fromJson(json['link'] as Map<String, dynamic>));
      }
    }

    schemaSeries = json['schema\$Series'] == null
        ? null
        : BookSchemaSeries.fromJson(
            json['schema\$Series'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (title != null) data['title'] = title!.toJson();
    if (id != null) data['id'] = id!.toJson();
    if (author != null) data['author'] = author!.toJson();
    if (published != null) data['published'] = published!.toJson();
    if (updated != null) data['updated'] = updated!.toJson();
    if (dctermsLanguage != null) {
      data['dcterms\$language'] = dctermsLanguage!.toJson();
    }
    if (dctermsPublisher != null) {
      data['dcterms\$publisher'] = dctermsPublisher!.toJson();
    }
    if (dctermsIssued != null) {
      data['dcterms\$issued'] = dctermsIssued!.toJson();
    }
    if (category != null) {
      data['category'] = category!.map((e) => e.toJson()).toList();
    }
    if (link != null) {
      data['link'] = link!.map((e) => e.toJson()).toList();
    }
    if (schemaSeries != null) {
      data['schema\$Series'] = schemaSeries!.toJson();
    }

    if (summary != null) data['summary'] = summary!.toJson();
    return data;
  }
}
