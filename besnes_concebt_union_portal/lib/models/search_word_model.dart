import 'dart:convert';

List<SearchWordModel> searchWordModelFromJson(String str) =>
    List<SearchWordModel>.from(
        json.decode(str).map((x) => SearchWordModel.fromJson(x)));

String searchWordModelToJson(List<SearchWordModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchWordModel {
  String barcode;
  String itemARDescription;
  double barcodePrice;

  SearchWordModel({this.barcode, this.itemARDescription, this.barcodePrice});

  SearchWordModel.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'];
    itemARDescription = json['item_AR_Description'];
    barcodePrice = json['barcode_Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcode'] = this.barcode;
    data['item_AR_Description'] = this.itemARDescription;
    data['barcode_Price'] = this.barcodePrice;
    return data;
  }
}
