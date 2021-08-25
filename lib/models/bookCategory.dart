class BookCategory {
  String? label;
  String? term;
  String? scheme;

  BookCategory({this.label, this.term, this.scheme});

  BookCategory.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    term = json['term'];
    scheme = json['scheme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label'] = this.label;
    data['term'] = this.term;
    data['scheme'] = this.scheme;
    return data;
  }
}
