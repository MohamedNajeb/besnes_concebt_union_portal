import 'dart:convert';

SingleWorkMemberModel singleWorkMemberModelFromJson(String str) =>
    SingleWorkMemberModel.fromJson(json.decode(str));

String singleWorkMemberModelToJson(SingleWorkMemberModel data) =>
    json.encode(data.toJson());

class SingleWorkMemberModel {
  SingleMemberResults results;

  SingleWorkMemberModel({
    this.results,
  });

  factory SingleWorkMemberModel.fromJson(Map<String, dynamic> json) =>
      SingleWorkMemberModel(
        results: json["results"] == null
            ? ""
            : SingleMemberResults.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null ? "" : results.toJson(),
      };
}

class SingleMemberResults {
  int editorId;
  String editorName;
  int jobTitleId;
  String jobTitle;
  String editorEmail;
  String editorPhone;
  dynamic birthDate;
  String description;
  String details;
  int displayOrder;
  dynamic seoKeyWords;
  dynamic seoDescription;

  SingleMemberResults({
    this.editorId,
    this.editorName,
    this.jobTitleId,
    this.jobTitle,
    this.editorEmail,
    this.editorPhone,
    this.birthDate,
    this.description,
    this.details,
    this.displayOrder,
    this.seoKeyWords,
    this.seoDescription,
  });

  factory SingleMemberResults.fromJson(Map<String, dynamic> json) =>
      SingleMemberResults(
        editorId: json["EditorID"] == null ? "" : json["EditorID"],
        editorName: json["EditorName"] == null ? "" : json["EditorName"],
        jobTitleId: json["JobTitleID"] == null ? "" : json["JobTitleID"],
        jobTitle: json["JobTitle"] == null ? "" : json["JobTitle"],
        editorEmail: json["EditorEmail"] == null ? "" : json["EditorEmail"],
        editorPhone: json["EditorPhone"] == null ? "" : json["EditorPhone"],
        birthDate: json["BirthDate"],
        description: json["Description"] == null ? "" : json["Description"],
        details: json["Details"] == null ? "" : json["Details"],
        displayOrder: json["DisplayOrder"] == null ? 0 : json["DisplayOrder"],
        seoKeyWords: json["SEOKeyWords"],
        seoDescription: json["SEODescription"],
      );

  Map<String, dynamic> toJson() => {
        "EditorID": editorId == null ? "" : editorId,
        "EditorName": editorName == null ? "" : editorName,
        "JobTitleID": jobTitleId == null ? "" : jobTitleId,
        "JobTitle": jobTitle == null ? "" : jobTitle,
        "EditorEmail": editorEmail == null ? "" : editorEmail,
        "EditorPhone": editorPhone == null ? "" : editorPhone,
        "BirthDate": birthDate,
        "Description": description == null ? "" : description,
        "Details": details == null ? "" : details,
        "DisplayOrder": displayOrder == null ? "" : displayOrder,
        "SEOKeyWords": seoKeyWords,
        "SEODescription": seoDescription,
      };
}
