import 'dart:convert';

StoryDetailsModel storyDetailsModelFromJson(String str) =>
    StoryDetailsModel.fromJson(json.decode(str));

String storyDetailsModelToJson(StoryDetailsModel data) =>
    json.encode(data.toJson());

class StoryDetailsModel {
  DetailsResults results;

  StoryDetailsModel({
    this.results,
  });

  factory StoryDetailsModel.fromJson(Map<String, dynamic> json) =>
      StoryDetailsModel(
        results: json["results"] == null
            ? null
            : DetailsResults.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null ? null : results.toJson(),
      };
}

class DetailsResults {
  int newId;
  int newTypeId;
  dynamic byLine;
  String title;
  String brief;
  String body;
  dynamic seoKeyWords;
  String publishDate;
  DateTime lastUpdateDate;
  int newStatus;
  String newStatusName;
  int newSectionId;
  String newSectionName;
  int pictureId;
  dynamic pictureCaption;
  String pictureName;
  dynamic editorId;
  dynamic editorName;
  dynamic views;
  bool isUsed;
  dynamic displayOrder;

  DetailsResults({
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

  factory DetailsResults.fromJson(Map<String, dynamic> json) => DetailsResults(
        newId: json["NewID"] == null ? null : json["NewID"],
        newTypeId: json["NewTypeID"] == null ? null : json["NewTypeID"],
        byLine: json["ByLine"],
        title: json["Title"] == null ? null : json["Title"],
        brief: json["Brief"] == null ? null : json["Brief"],
        body: json["Body"] == null ? null : json["Body"],
        seoKeyWords: json["SEOKeyWords"],
        publishDate: json["PublishDate"] == null ? null : json["PublishDate"],
        lastUpdateDate: json["LastUpdateDate"] == null
            ? null
            : DateTime.parse(json["LastUpdateDate"]),
        newStatus: json["NewStatus"] == null ? null : json["NewStatus"],
        newStatusName:
            json["NewStatusName"] == null ? null : json["NewStatusName"],
        newSectionId:
            json["NewSectionID"] == null ? null : json["NewSectionID"],
        newSectionName:
            json["NewSectionName"] == null ? null : json["NewSectionName"],
        pictureId: json["PictureID"] == null ? null : json["PictureID"],
        pictureCaption: json["PictureCaption"],
        pictureName: json["PictureName"] == null ? null : json["PictureName"],
        editorId: json["EditorID"],
        editorName: json["EditorName"],
        views: json["Views"],
        isUsed: json["IsUsed"] == null ? null : json["IsUsed"],
        displayOrder: json["DisplayOrder"],
      );

  Map<String, dynamic> toJson() => {
        "NewID": newId == null ? null : newId,
        "NewTypeID": newTypeId == null ? null : newTypeId,
        "ByLine": byLine,
        "Title": title == null ? null : title,
        "Brief": brief == null ? null : brief,
        "Body": body == null ? null : body,
        "SEOKeyWords": seoKeyWords,
        "PublishDate": publishDate == null ? null : publishDate,
        "LastUpdateDate":
            lastUpdateDate == null ? null : lastUpdateDate.toIso8601String(),
        "NewStatus": newStatus == null ? null : newStatus,
        "NewStatusName": newStatusName == null ? null : newStatusName,
        "NewSectionID": newSectionId == null ? null : newSectionId,
        "NewSectionName": newSectionName == null ? null : newSectionName,
        "PictureID": pictureId == null ? null : pictureId,
        "PictureCaption": pictureCaption,
        "PictureName": pictureName == null ? null : pictureName,
        "EditorID": editorId,
        "EditorName": editorName,
        "Views": views,
        "IsUsed": isUsed == null ? null : isUsed,
        "DisplayOrder": displayOrder,
      };
}
