class Link {
  String? rel;
  String? type;
  String? title;
  String? href;
  String? opdsActiveFacet;
  String? opdsFacetGroup;
  String? thrCount;

  Link({
    this.rel,
    this.title,
    this.type,
    this.thrCount,
    this.href,
    this.opdsActiveFacet,
    this.opdsFacetGroup,
  });

  Link.fromJson(Map<String, dynamic> json) {
    rel = json['rel'] as String?;
    title = json['title'] as String?;
    type = json['type'] as String?;
    href = json['href'] as String?;
    opdsFacetGroup = json['opds:facetGroup'] as String?;
    opdsActiveFacet = json['opds:activeFacet'] as String?;
    thrCount = json['thr:count'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['rel'] = rel;
    data['type'] = type;
    data['href'] = href;
    data['title'] = title;
    data['opds:activeFacet'] = opdsActiveFacet;
    data['opds:facetGroup'] = opdsFacetGroup;
    data['thr:count'] = thrCount;
    return data;
  }
}
