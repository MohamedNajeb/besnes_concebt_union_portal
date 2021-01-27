import 'dart:convert';

import 'package:unionportal/models/models.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

abstract class PriceComparisonRepository {
  Future<List<GetByBarcodeModel>> getItemByBarcode(String itemBarcode);
}

class PriceComparisonRepositoryImpl extends PriceComparisonRepository {
  http.Response getByBarcodeResponse;
  List<GetByBarcodeModel> _getByBarcodeList = new List<GetByBarcodeModel>();

  @override
  Future<List<GetByBarcodeModel>> getItemByBarcode(String itemBarcode) async {
    getByBarcodeResponse =
        await http.get("$BASE_URL_TWO/CoopsPrices/getbybarcode/$itemBarcode");

    if (getByBarcodeResponse.statusCode == 200) {
      print(getByBarcodeResponse.body);
      List<dynamic> values = new List<dynamic>();
      values = json.decode(getByBarcodeResponse.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _getByBarcodeList.add(GetByBarcodeModel.fromJson(map));
            print(_getByBarcodeList[0].itemName);
          }
        }
      }
      return _getByBarcodeList;
    } else if (getByBarcodeResponse.statusCode == 404) {
      print(getByBarcodeResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
