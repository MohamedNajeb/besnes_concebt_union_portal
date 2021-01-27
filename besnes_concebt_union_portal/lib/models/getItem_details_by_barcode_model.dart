import 'dart:convert';

import 'details.dart';

GetItemDetailsByBarcodeModel getItemDetailsByBarcodeModelFromJson(String str) =>
    GetItemDetailsByBarcodeModel.fromJson(json.decode(str));

String getItemDetailsByBarcodeModelToJson(GetItemDetailsByBarcodeModel data) =>
    json.encode(data.toJson());

class GetItemDetailsByBarcodeModel {
  String itemARDescription;
  double barcodePrice;
  List<Details> details;

  GetItemDetailsByBarcodeModel(
      {this.itemARDescription, this.barcodePrice, this.details});

  GetItemDetailsByBarcodeModel.fromJson(Map<String, dynamic> json) {
    itemARDescription = json['item_AR_Description'];
    barcodePrice = json['barcode_Price'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_AR_Description'] = this.itemARDescription;
    data['barcode_Price'] = this.barcodePrice;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
