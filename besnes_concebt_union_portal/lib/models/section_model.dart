import 'dart:convert';

SectionsModel sectionsModelFromJson(String str) =>
    SectionsModel.fromJson(json.decode(str));

String sectionsModelToJson(SectionsModel data) => json.encode(data.toJson());

class SectionsModel {
  List<SectionsResult> results;

  SectionsModel({
    this.results,
  });

  factory SectionsModel.fromJson(Map<String, dynamic> json) => SectionsModel(
        results: json["results"] == null
            ? null
            : List<SectionsResult>.from(
                json["results"].map((x) => SectionsResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class SectionsResult {
  int newSectionId;
  String newSectionName;
  dynamic parentId;
  bool hide;
  int displayOrder;
  dynamic seoKeywords;
  dynamic seoDescription;

  SectionsResult({
    this.newSectionId,
    this.newSectionName,
    this.parentId,
    this.hide,
    this.displayOrder,
    this.seoKeywords,
    this.seoDescription,
  });

  factory SectionsResult.fromJson(Map<String, dynamic> json) => SectionsResult(
        newSectionId:
            json["NewSectionID"] == null ? null : json["NewSectionID"],
        newSectionName:
            json["NewSectionName"] == null ? null : json["NewSectionName"],
        parentId: json["ParentID"],
        hide: json["Hide"] == null ? null : json["Hide"],
        displayOrder:
            json["DisplayOrder"] == null ? null : json["DisplayOrder"],
        seoKeywords: json["SEOKeywords"],
        seoDescription: json["SEODescription"],
      );

  Map<String, dynamic> toJson() => {
        "NewSectionID": newSectionId == null ? null : newSectionId,
        "NewSectionName": newSectionName == null ? null : newSectionName,
        "ParentID": parentId,
        "Hide": hide == null ? null : hide,
        "DisplayOrder": displayOrder == null ? null : displayOrder,
        "SEOKeywords": seoKeywords,
        "SEODescription": seoDescription,
      };
}
