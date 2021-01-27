import 'dart:convert';

AllWorkMembersModel allWorkMembersModelFromJson(String str) =>
    AllWorkMembersModel.fromJson(json.decode(str));

String allWorkMembersModelToJson(AllWorkMembersModel data) =>
    json.encode(data.toJson());

class AllWorkMembersModel {
  List<WorkMembersResult> results;

  AllWorkMembersModel({
    this.results,
  });

  factory AllWorkMembersModel.fromJson(Map<String, dynamic> json) =>
      AllWorkMembersModel(
        results: json["results"] == null
            ? ""
            : List<WorkMembersResult>.from(
                json["results"].map((x) => WorkMembersResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? ""
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class WorkMembersResult {
  int editorId;
  String editorName;
  int jobTitleId;
  String jobTitle;

  WorkMembersResult({
    this.editorId,
    this.editorName,
    this.jobTitleId,
    this.jobTitle,
  });

  factory WorkMembersResult.fromJson(Map<String, dynamic> json) =>
      WorkMembersResult(
        editorId: json["EditorID"] == null ? "" : json["EditorID"],
        editorName: json["EditorName"] == null ? "" : json["EditorName"],
        jobTitleId: json["JobTitleID"] == null ? "" : json["JobTitleID"],
        jobTitle: json["JobTitle"] == null ? "" : json["JobTitle"],
      );

  Map<String, dynamic> toJson() => {
        "EditorID": editorId == null ? "" : editorId,
        "EditorName": editorName == null ? "" : editorName,
        "JobTitleID": jobTitleId == null ? "" : jobTitleId,
        "JobTitle": jobTitle == null ? "" : jobTitle,
      };
}
