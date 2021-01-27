import 'dart:convert';

List<GetByBarcodeModel> salesLocationModelFromJson(String str) =>
    List<GetByBarcodeModel>.from(
        json.decode(str).map((x) => GetByBarcodeModel.fromJson(x)));

String salesLocationModelToJson(List<GetByBarcodeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetByBarcodeModel {
  int companyID;
  String companyName;
  String itemName;
  double price;
  String lastUploadDate;

  GetByBarcodeModel(
      {this.companyID,
      this.companyName,
      this.itemName,
      this.price,
      this.lastUploadDate});

  GetByBarcodeModel.fromJson(Map<String, dynamic> json) {
    companyID = json['company_ID'];
    companyName = json['company_Name'];
    itemName = json['item_Name'];
    price = json['price'];
    lastUploadDate = json['last_Upload_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_ID'] = this.companyID;
    data['company_Name'] = this.companyName;
    data['item_Name'] = this.itemName;
    data['price'] = this.price;
    data['last_Upload_Date'] = this.lastUploadDate;
    return data;
  }
}
