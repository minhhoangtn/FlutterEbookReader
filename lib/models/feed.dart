import 'package:ebook_reader/models/author.dart';
import 'package:ebook_reader/models/entry.dart';
import 'package:ebook_reader/models/id.dart';
import 'package:ebook_reader/models/link.dart';

class Feed {
  String? xmlnsDcterms;
  String? xmlnsThr;
  String? xmlnsApp;
  String? xmlnsOpensearch;
  String? xmlns;
  String? xmlnsOpds;
  String? xmlnsXsi;
  String? xmlLang;
  String? xmlnsOdl;
  String? xmlnsSchema;
  String? xmlnsOpf;
  Id? id;
  Id? title;
  Id? updated;
  Id? icon;
  Author? author;
  List<Link>? link;
  Id? opensearchTotalResults;
  Id? opensearchItemsPerPage;
  Id? opensearchStartIndex;
  List<Entry>? entry;

  Feed({
    this.xmlLang,
    this.xmlns,
    this.xmlnsApp,
    this.xmlnsDcterms,
    this.xmlnsOdl,
    this.xmlnsOpds,
    this.xmlnsOpensearch,
    this.xmlnsOpf,
    this.xmlnsSchema,
    this.xmlnsThr,
    this.xmlnsXsi,
    this.id,
    this.updated,
    this.icon,
    this.author,
    this.title,
    this.entry,
    this.link,
    this.opensearchItemsPerPage,
    this.opensearchStartIndex,
    this.opensearchTotalResults,
  });

  Feed.fromJson(Map<String, dynamic> json) {
    xmlLang = json['xml:lang'] as String?;

    xmlns = json['xmlns'] as String?;

    xmlnsDcterms = json['xmlns\$dcterms'] as String?;

    xmlnsThr = json['xmlns\$thr'] as String?;

    xmlnsApp = json['xmlns\$app'] as String?;

    xmlnsOpensearch = json['xmlns\$opensearch'] as String?;

    xmlnsOpds = json['xmlns\$opds'] as String?;

    xmlnsXsi = json['xmlns\$xsi'] as String?;

    xmlnsOdl = json['xmlns\$odl'] as String?;

    xmlnsSchema = json['xmlns\$schema'] as String?;

    xmlnsOpf = json['xmlns\$opf'] as String?;

    id = json['id'] == null
        ? null
        : Id.fromJson(json['id'] as Map<String, dynamic>);

    title = json['title'] == null
        ? null
        : Id.fromJson(json['title'] as Map<String, dynamic>);

    updated = json['updated'] == null
        ? null
        : Id.fromJson(json['updated'] as Map<String, dynamic>);

    icon = json['icon'] == null
        ? null
        : Id.fromJson(json['icon'] as Map<String, dynamic>);

    author = json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>);

    if (json['link'] != null) {
      final String t = json['link'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        link = [];
        json['link'].forEach((v) {
          link?.add(Link.fromJson(v as Map<String, dynamic>));
        });
      } else {
        link = [];
        link?.add(Link.fromJson(json['link'] as Map<String, dynamic>));
      }
    }

    opensearchTotalResults = json['opensearch\$totalResults'] == null
        ? null
        : Id.fromJson(json['opensearch\$totalResults'] as Map<String, dynamic>);

    opensearchStartIndex = json['opensearch\$startIndex'] == null
        ? null
        : Id.fromJson(json['opensearch\$startIndex'] as Map<String, dynamic>);

    opensearchItemsPerPage = json['opensearch\$itemsPerPage'] == null
        ? null
        : Id.fromJson(json['opensearch\$itemsPerPage'] as Map<String, dynamic>);

    if (json['entry'] != null) {
      final String t = json['entry'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        entry = [];
        json['entry'].forEach((v) {
          entry?.add(Entry.fromJson(v as Map<String, dynamic>));
        });
      } else {
        entry = [];
        entry?.add(Entry.fromJson(json['entry'] as Map<String, dynamic>));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['xml:lang'] = xmlLang;
    data['xmlns'] = xmlns;
    data['xmlns\$dcterms'] = xmlnsDcterms;
    data['xmlns\$thr'] = xmlnsThr;
    data['xmlns\$app'] = xmlnsApp;
    data['xmlns\$opensearch'] = xmlnsOpensearch;
    data['xmlns\$opds'] = xmlnsOpds;
    data['xmlns\$xsi'] = xmlnsXsi;
    data['xmlns\$odl'] = xmlnsOdl;
    data['xmlns\$schema'] = xmlnsSchema;
    data['xmlns\$opf'] = xmlnsOpf;

    if (id != null) data['id'] = id!.toJson();
    if (title != null) data['title'] = title!.toJson();
    if (updated != null) data['updated'] = updated!.toJson();
    if (icon != null) data['icon'] = icon!.toJson();

    if (author != null) data['author'] = author!.toJson();

    if (link != null) data['link'] = link!.map((e) => e.toJson()).toList();

    if (opensearchItemsPerPage != null) {
      data['opensearch\$totalResults'] = opensearchTotalResults!.toJson();
    }
    if (opensearchStartIndex != null) {
      data['opensearch\$startIndex'] = opensearchStartIndex!.toJson();
    }
    if (opensearchItemsPerPage != null) {
      data['opensearch\$itemsPerPage'] = opensearchItemsPerPage!.toJson();
    }

    if (entry != null) {
      data['entry'] = entry!.map((e) => e.toJson()).toList();
    }

    return data;
  }
}
