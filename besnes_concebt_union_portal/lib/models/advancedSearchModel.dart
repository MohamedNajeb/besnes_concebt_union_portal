import 'dart:convert';

AdvancedSearchModel advancedSearchModelFromJson(String str) =>
    AdvancedSearchModel.fromJson(json.decode(str));

String advancedSearchModelToJson(AdvancedSearchModel data) =>
    json.encode(data.toJson());

class AdvancedSearchModel {
  List<SearchResult> results;

  AdvancedSearchModel({
    this.results,
  });

  factory AdvancedSearchModel.fromJson(Map<String, dynamic> json) =>
      AdvancedSearchModel(
        results: json["results"] == null
            ? null
            : List<SearchResult>.from(
                json["results"].map((x) => SearchResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class SearchResult {
  int newId;
  int newTypeId;
  dynamic byLine;
  String title;
  String brief;
  dynamic body;
  dynamic seoKeyWords;
  String publishDate;
  dynamic lastUpdateDate;
  dynamic newStatus;
  dynamic newStatusName;
  int newSectionId;
  String newSectionName;
  dynamic pictureId;
  dynamic pictureCaption;
  String pictureName;
  dynamic editorId;
  dynamic editorName;
  dynamic views;
  bool isUsed;
  dynamic displayOrder;

  SearchResult({
    this.newId,
    this.newTypeId,
    this.byLine,
    this.title,
    this.brief,
    this.body,
    this.seoKeyWords,
    this.publishDate,
    this.lastUpdateDate,
    this.newStatus,
    this.newStatusName,
    this.newSectionId,
    this.newSectionName,
    this.pictureId,
    this.pictureCaption,
    this.pictureName,
    this.editorId,
    this.editorName,
    this.views,
    this.isUsed,
    this.displayOrder,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        newId: json["NewID"] == null ? "" : json["NewID"],
        newTypeId: json["NewTypeID"] == null ? "" : json["NewTypeID"],
        byLine: json["ByLine"],
        title: json["Title"] == null ? "" : json["Title"],
        brief: json["Brief"] == null ? "" : json["Brief"],
        body: json["Body"],
        seoKeyWords: json["SEOKeyWords"],
        publishDate: json["PublishDate"] == null ? "" : json["PublishDate"],
        lastUpdateDate: json["LastUpdateDate"],
        newStatus: json["NewStatus"],
        newStatusName: json["NewStatusName"],
        newSectionId: json["NewSectionID"] == null ? "" : json["NewSectionID"],
        newSectionName:
            json["NewSectionName"] == null ? "" : json["NewSectionName"],
        pictureId: json["PictureID"],
        pictureCaption: json["PictureCaption"],
        pictureName: json["PictureName"] == null ? "" : json["PictureName"],
        editorId: json["EditorID"],
        editorName: json["EditorName"],
        views: json["Views"],
        isUsed: json["IsUsed"] == null ? "" : json["IsUsed"],
        displayOrder: json["DisplayOrder"],
      );

  Map<String, dynamic> toJson() => {
        "NewID": newId == null ? "" : newId,
        "NewTypeID": newTypeId == null ? "" : newTypeId,
        "ByLine": byLine,
        "Title": title == null ? "" : title,
        "Brief": brief == null ? "" : brief,
        "Body": body,
        "SEOKeyWords": seoKeyWords,
        "PublishDate": publishDate == null ? "" : publishDate,
        "LastUpdateDate": lastUpdateDate,
        "NewStatus": newStatus,
        "NewStatusName": newStatusName,
        "NewSectionID": newSectionId == null ? "" : newSectionId,
        "NewSectionName": newSectionName == null ? "" : newSectionName,
        "PictureID": pictureId,
        "PictureCaption": pictureCaption,
        "PictureName": pictureName == null ? "" : pictureName,
        "EditorID": editorId,
        "EditorName": editorName,
        "Views": views,
        "IsUsed": isUsed == null ? "" : isUsed,
        "DisplayOrder": displayOrder,
      };
}
