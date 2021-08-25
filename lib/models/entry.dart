import 'package:ebook_reader/models/bookAuthor.dart';
import 'package:ebook_reader/models/bookCategory.dart';
import 'package:ebook_reader/models/bookLink.dart';
import 'package:ebook_reader/models/bookSchemaSeries.dart';
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
    title = json['title'] == null ? null : Id.fromJson(json['title']);

    id = json['id'] == null ? null : Id.fromJson(json['id']);

    if (json['author'].runtimeType.toString() == 'List<dynamic>')
      author = (json['author'] == null)
          ? null
          : BookAuthor.fromJsonList(json['author']);
    else
      author =
          json['author'] == null ? null : BookAuthor.fromJson(json['author']);

    published =
        json['published'] == null ? null : Id.fromJson(json['published']);

    updated = json['updated'] == null ? null : Id.fromJson(json['updated']);

    dctermsLanguage = json['dcterms\$language'] == null
        ? null
        : Id.fromJson(json['dcterms\$language']);

    dctermsPublisher = json['dcterms\$publisher'] == null
        ? null
        : Id.fromJson(json['dcterms\$publisher']);

    dctermsIssued = json['dcterms\$issued'] == null
        ? null
        : Id.fromJson(json['dcterms\$issued']);

    summary = json['summary'] == null ? null : Id.fromJson(json['summary']);

    if (json['category'] != null) {
      String t = json['category'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        category = [];
        json['category'].forEach((v) {
          category?.add(BookCategory.fromJson(v));
        });
      } else {
        category = [];
        category?.add(BookCategory.fromJson(json['category']));
      }
    }

    if (json['link'] != null) {
      String t = json['link'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        link = [];
        json['link'].forEach((v) {
          link?.add(BookLink.fromJson(v));
        });
      } else {
        link = [];
        link?.add(BookLink.fromJson(json['link']));
      }
    }

    schemaSeries = json['schema\$Series'] == null
        ? null
        : BookSchemaSeries.fromJson(json['schema\$Series']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if (this.title != null) data['title'] = this.title!.toJson();
    if (this.id != null) data['id'] = this.id!.toJson();
    if (this.author != null) data['author'] = this.author!.toJson();
    if (this.published != null) data['published'] = this.published!.toJson();
    if (this.updated != null) data['updated'] = this.updated!.toJson();
    if (this.dctermsLanguage != null)
      data['dcterms\$language'] = this.dctermsLanguage!.toJson();
    if (this.dctermsPublisher != null)
      data['dcterms\$publisher'] = this.dctermsPublisher!.toJson();
    if (this.dctermsIssued != null)
      data['dcterms\$issued'] = this.dctermsIssued!.toJson();
    if (this.category != null) {
      data['category'] = this.category!.map((e) => e.toJson()).toList();
    }
    if (this.link != null) {
      data['link'] = this.link!.map((e) => e.toJson()).toList();
    }
    if (this.schemaSeries != null)
      data['schema\$Series'] = this.schemaSeries!.toJson();

    if (this.summary != null) data['summary'] = this.summary!.toJson();
    return data;
  }
}
