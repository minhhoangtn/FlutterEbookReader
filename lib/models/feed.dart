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
    xmlLang = json['xml:lang'];

    xmlns = json['xmlns'];

    xmlnsDcterms = json['xmlns\$dcterms'];

    xmlnsThr = json['xmlns\$thr'];

    xmlnsApp = json['xmlns\$app'];

    xmlnsOpensearch = json['xmlns\$opensearch'];

    xmlnsOpds = json['xmlns\$opds'];

    xmlnsXsi = json['xmlns\$xsi'];

    xmlnsOdl = json['xmlns\$odl'];

    xmlnsSchema = json['xmlns\$schema'];

    xmlnsOpf = json['xmlns\$opf'];

    id = json['id'] == null ? null : Id.fromJson(json['id']);

    title = json['title'] == null ? null : Id.fromJson(json['title']);

    updated = json['updated'] == null ? null : Id.fromJson(json['updated']);

    icon = json['icon'] == null ? null : Id.fromJson(json['icon']);

    author = json['author'] == null ? null : Author.fromJson(json['author']);

    if (json['link'] != null) {
      String t = json['link'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        link = [];
        json['link'].forEach((v) {
          link?.add(Link.fromJson(v));
        });
      } else {
        link = [];
        link?.add(Link.fromJson(json['link']));
      }
    }

    opensearchTotalResults = json['opensearch\$totalResults'] == null
        ? null
        : Id.fromJson(json['opensearch\$totalResults']);

    opensearchStartIndex = json['opensearch\$startIndex'] == null
        ? null
        : Id.fromJson(json['opensearch\$startIndex']);

    opensearchItemsPerPage = json['opensearch\$itemsPerPage'] == null
        ? null
        : Id.fromJson(json['opensearch\$itemsPerPage']);

    if (json['entry'] != null) {
      String t = json['entry'].runtimeType.toString();
      if (t == 'List<dynamic>' || t == '_GrowableList<dynamic>') {
        entry = [];
        json['entry'].forEach((v) {
          entry?.add(Entry.fromJson(v));
        });
      } else {
        entry = [];
        entry?.add(Entry.fromJson(json['entry']));
      }
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['xml:lang'] = this.xmlLang;
    data['xmlns'] = this.xmlns;
    data['xmlns\$dcterms'] = this.xmlnsDcterms;
    data['xmlns\$thr'] = this.xmlnsThr;
    data['xmlns\$app'] = this.xmlnsApp;
    data['xmlns\$opensearch'] = this.xmlnsOpensearch;
    data['xmlns\$opds'] = this.xmlnsOpds;
    data['xmlns\$xsi'] = this.xmlnsXsi;
    data['xmlns\$odl'] = this.xmlnsOdl;
    data['xmlns\$schema'] = this.xmlnsSchema;
    data['xmlns\$opf'] = this.xmlnsOpf;

    if (this.id != null) data['id'] = this.id!.toJson();
    if (this.title != null) data['title'] = this.title!.toJson();
    if (this.updated != null) data['updated'] = this.updated!.toJson();
    if (this.icon != null) data['icon'] = this.icon!.toJson();

    if (this.author != null) data['author'] = this.author!.toJson();

    if (this.link != null) data['link'] = link!.map((e) => e.toJson()).toList();

    if (this.opensearchItemsPerPage != null)
      data['opensearch\$totalResults'] = this.opensearchTotalResults!.toJson();
    if (this.opensearchStartIndex != null)
      data['opensearch\$startIndex'] = this.opensearchStartIndex!.toJson();
    if (this.opensearchItemsPerPage != null)
      data['opensearch\$itemsPerPage'] = this.opensearchItemsPerPage!.toJson();

    if (this.entry != null)
      data['entry'] = this.entry!.map((e) => e.toJson()).toList();

    return data;
  }
}
