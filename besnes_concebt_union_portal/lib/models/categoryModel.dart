// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<CategoryResult> results;

  CategoryModel({
    this.results,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        results: json["results"] == null
            ? ""
            : List<CategoryResult>.from(
                json["results"].map((x) => CategoryResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? ""
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class CategoryResult {
  int newId;
  int newTypeId;
  int newSectionId;
  String newSectionName;
  dynamic sectionSeoKeywords;
  dynamic sectionSeoDescription;
  dynamic byLine;
  dynamic editorId;
  String title;
  String brief;
  int pictureId;
  dynamic pictureCaption;
  String pictureName;
  String picCaption;
  bool isMainPicture;
  String publishDate;
  int displayOrder;
  int positionInHomePage;
  dynamic videoLink;

  CategoryResult({
    this.newId,
    this.newTypeId,
    this.newSectionId,
    this.newSectionName,
    this.sectionSeoKeywords,
    this.sectionSeoDescription,
    this.byLine,
    this.editorId,
    this.title,
    this.brief,
    this.pictureId,
    this.pictureCaption,
    this.pictureName,
    this.picCaption,
    this.isMainPicture,
    this.publishDate,
    this.displayOrder,
    this.positionInHomePage,
    this.videoLink,
  });

  factory CategoryResult.fromJson(Map<String, dynamic> json) => CategoryResult(
        newId: json["NewID"] == null ? "" : json["NewID"],
        newTypeId: json["NewTypeID"] == null ? "" : json["NewTypeID"],
        newSectionId: json["NewSectionID"] == null ? "" : json["NewSectionID"],
        newSectionName:
            json["NewSectionName"] == null ? "" : json["NewSectionName"],
        sectionSeoKeywords: json["SectionSEOKeywords"],
        sectionSeoDescription: json["SectionSEODescription"],
        byLine: json["ByLine"],
        editorId: json["EditorID"],
        title: json["Title"] == null ? "" : json["Title"],
        brief: json["Brief"] == null ? "" : json["Brief"],
        pictureId: json["PictureID"] == null ? "" : json["PictureID"],
        pictureCaption: json["PictureCaption"],
        pictureName: json["PictureName"] == null ? "" : json["PictureName"],
        picCaption: json["PicCaption"] == null ? "" : json["PicCaption"],
        isMainPicture:
            json["IsMainPicture"] == null ? "" : json["IsMainPicture"],
        publishDate: json["PublishDate"] == null ? "" : json["PublishDate"],
        displayOrder: json["DisplayOrder"] == null ? "" : json["DisplayOrder"],
        positionInHomePage: json["PositionInHomePage"] == null
            ? ""
            : json["PositionInHomePage"],
        videoLink: json["VideoLink"],
      );

  Map<String, dynamic> toJson() => {
        "NewID": newId == null ? "" : newId,
        "NewTypeID": newTypeId == null ? "" : newTypeId,
        "NewSectionID": newSectionId == null ? "" : newSectionId,
        "NewSectionName": newSectionName == null ? "" : newSectionName,
        "SectionSEOKeywords": sectionSeoKeywords,
        "SectionSEODescription": sectionSeoDescription,
        "ByLine": byLine,
        "EditorID": editorId,
        "Title": title == null ? "" : title,
        "Brief": brief == null ? "" : brief,
        "PictureID": pictureId == null ? "" : pictureId,
        "PictureCaption": pictureCaption,
        "PictureName": pictureName == null ? "" : pictureName,
        "PicCaption": picCaption == null ? "" : picCaption,
        "IsMainPicture": isMainPicture == null ? "" : isMainPicture,
        "PublishDate": publishDate == null ? "" : publishDate,
        "DisplayOrder": displayOrder == null ? "" : displayOrder,
        "PositionInHomePage":
            positionInHomePage == null ? "" : positionInHomePage,
        "VideoLink": videoLink,
      };
}
