class BookSchemaSeries {
  String? schemaPosition;
  String? schemaName;
  String? schemaUrl;

  BookSchemaSeries({this.schemaName, this.schemaPosition, this.schemaUrl});

  BookSchemaSeries.fromJson(Map<String, dynamic> json) {
    schemaPosition = json['schema:position'] as String?;
    schemaName = json['schema:name'] as String?;
    schemaUrl = json['schema:url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['schema:position'] = schemaPosition;
    data['schema:name'] = schemaName;
    data['schema:url'] = schemaUrl;
    return data;
  }
}
