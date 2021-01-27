import 'dart:convert';
//import 'package:meta/meta.dart';
//import 'package:musharrafblocportal/models/models.dart';

HomeSliderModel homeSliderModelFromJson(String str) =>
    HomeSliderModel.fromJson(json.decode(str));

String homeSliderModelToJson(HomeSliderModel data) =>
    json.encode(data.toJson());

class HomeSliderModel {
  List<SliderResult> results;

  HomeSliderModel({
    this.results,
  });

  factory HomeSliderModel.fromJson(Map<String, dynamic> json) =>
      HomeSliderModel(
        results: json["results"] == null
            ? null
            : List<SliderResult>.from(
                json["results"].map((x) => SliderResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class SliderResult {
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
  String pictureCaption;
  String pictureName;
  String picCaption;
  bool isMainPicture;
  DateTime publishDate;
  int displayOrder;
  int positionInHomePage;
  dynamic videoLink;

  SliderResult({
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

  factory SliderResult.fromJson(Map<String, dynamic> json) => SliderResult(
        newId: json["NewID"] == null ? null : json["NewID"],
        newTypeId: json["NewTypeID"] == null ? null : json["NewTypeID"],
        newSectionId:
            json["NewSectionID"] == null ? null : json["NewSectionID"],
        newSectionName:
            json["NewSectionName"] == null ? null : json["NewSectionName"],
        sectionSeoKeywords: json["SectionSEOKeywords"],
        sectionSeoDescription: json["SectionSEODescription"],
        byLine: json["ByLine"],
        editorId: json["EditorID"],
        title: json["Title"] == null ? null : json["Title"],
        brief: json["Brief"] == null ? null : json["Brief"],
        pictureId: json["PictureID"] == null ? null : json["PictureID"],
        pictureCaption:
            json["PictureCaption"] == null ? null : json["PictureCaption"],
        pictureName: json["PictureName"] == null ? null : json["PictureName"],
        picCaption: json["PicCaption"] == null ? null : json["PicCaption"],
        isMainPicture:
            json["IsMainPicture"] == null ? null : json["IsMainPicture"],
        publishDate: json["PublishDate"] == null
            ? null
            : DateTime.parse(json["PublishDate"]),
        displayOrder:
            json["DisplayOrder"] == null ? null : json["DisplayOrder"],
        positionInHomePage: json["PositionInHomePage"] == null
            ? null
            : json["PositionInHomePage"],
        videoLink: json["VideoLink"],
      );

  Map<String, dynamic> toJson() => {
        "NewID": newId == null ? null : newId,
        "NewTypeID": newTypeId == null ? null : newTypeId,
        "NewSectionID": newSectionId == null ? null : newSectionId,
        "NewSectionName": newSectionName == null ? null : newSectionName,
        "SectionSEOKeywords": sectionSeoKeywords,
        "SectionSEODescription": sectionSeoDescription,
        "ByLine": byLine,
        "EditorID": editorId,
        "Title": title == null ? null : title,
        "Brief": brief == null ? null : brief,
        "PictureID": pictureId == null ? null : pictureId,
        "PictureCaption": pictureCaption == null ? null : pictureCaption,
        "PictureName": pictureName == null ? null : pictureName,
        "PicCaption": picCaption == null ? null : picCaption,
        "IsMainPicture": isMainPicture == null ? null : isMainPicture,
        "PublishDate":
            publishDate == null ? null : publishDate.toIso8601String(),
        "DisplayOrder": displayOrder == null ? null : displayOrder,
        "PositionInHomePage":
            positionInHomePage == null ? null : positionInHomePage,
        "VideoLink": videoLink,
      };
}
