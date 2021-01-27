import 'dart:convert';

List<BarcodeModel> barcodeModelFromJson(String str) => List<BarcodeModel>.from(
    json.decode(str).map((x) => BarcodeModel.fromJson(x)));

String barcodeModelToJson(List<BarcodeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BarcodeModel {
  BarcodeModel({
    this.itemKey,
    this.itemRef,
    this.itemArDescription,
    this.itemEnDescription,
    this.itemSpecifications,
    this.imageUrl,
    this.notes,
    this.isBlocked,
    this.barcode,
    this.barcodeFactor,
    this.barcodePrice,
    this.isBarcodeBlocked,
    this.unitArDescription,
    this.unitEnDescription,
  });

  int itemKey;
  String itemRef;
  String itemArDescription;
  String itemEnDescription;
  String itemSpecifications;
  String imageUrl;
  String notes;
  bool isBlocked;
  String barcode;
  double barcodeFactor;
  double barcodePrice;
  bool isBarcodeBlocked;
  String unitArDescription;
  String unitEnDescription;

  factory BarcodeModel.fromJson(Map<String, dynamic> json) => BarcodeModel(
        itemKey: json["item_Key"] == null ? 0 : json["item_Key"],
        itemRef: json["item_Ref"] == null ? " " : json["item_Ref"],
        itemArDescription: json["item_AR_Description"] == null
            ? " "
            : json["item_AR_Description"],
        itemEnDescription: json["item_EN_Description"] == null
            ? " "
            : json["item_EN_Description"],
        itemSpecifications: json["item_Specifications"] == null
            ? null
            : json["item_Specifications"],
        imageUrl: json["image_Url"] == null ? " " : json["image_Url"],
        notes: json["notes"] == null ? " " : json["notes"],
        isBlocked: json["is_Blocked"] == null ? 0 : json["is_Blocked"],
        barcode: json["barcode"] == null ? " " : json["barcode"],
        barcodeFactor:
            json["barcode_Factor"] == null ? 0.0 : json["barcode_Factor"],
        barcodePrice: json["barcode_Price"] == null
            ? 0.0
            : json["barcode_Price"].toDouble(),
        isBarcodeBlocked:
            json["is_Barcode_Blocked"] == null ? 0 : json["is_Barcode_Blocked"],
        unitArDescription: json["unit_Ar_Description"] == null
            ? " "
            : json["unit_Ar_Description"],
        unitEnDescription: json["unit_En_Description"] == null
            ? " "
            : json["unit_En_Description"],
      );

  Map<String, dynamic> toJson() => {
        "item_Key": itemKey == null ? 0 : itemKey,
        "item_Ref": itemRef == null ? " " : itemRef,
        "item_AR_Description":
            itemArDescription == null ? " " : itemArDescription,
        "item_EN_Description":
            itemEnDescription == null ? " " : itemEnDescription,
        "item_Specifications":
            itemSpecifications == null ? " " : itemSpecifications,
        "image_Url": imageUrl == null ? " " : imageUrl,
        "notes": notes == null ? " " : notes,
        "is_Blocked": isBlocked == null ? 0 : isBlocked,
        "barcode": barcode == null ? " " : barcode,
        "barcode_Factor": barcodeFactor == null ? 0.0 : barcodeFactor,
        "barcode_Price": barcodePrice == null ? 0.0 : barcodePrice,
        "is_Barcode_Blocked": isBarcodeBlocked == null ? 0 : isBarcodeBlocked,
        "unit_Ar_Description":
            unitArDescription == null ? " " : unitArDescription,
        "unit_En_Description":
            unitEnDescription == null ? " " : unitEnDescription,
      };
}
