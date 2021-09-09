class BookCategory {
  String? label;
  String? term;
  String? scheme;

  BookCategory({this.label, this.term, this.scheme});

  BookCategory.fromJson(Map<String, dynamic> json) {
    label = json['label'] as String?;
    term = json['term'] as String?;
    scheme = json['scheme'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label'] = label;
    data['term'] = term;
    data['scheme'] = scheme;
    return data;
  }
}
