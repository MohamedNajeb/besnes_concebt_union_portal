import 'package:unionportal/constants.dart';
import 'package:unionportal/models/getItem_details_by_barcode_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductDetailsRepository {
  Future<GetItemDetailsByBarcodeModel> getItemDetailsByBarcodeModel(
      String itemBarcode);
}

class ProductDetailsRepositoryImpl extends ProductDetailsRepository {
  http.Response getItemDetailsByBarcodeModelResponse;
  @override
  Future<GetItemDetailsByBarcodeModel> getItemDetailsByBarcodeModel(
      String itemBarcode) async {
    getItemDetailsByBarcodeModelResponse = await http
        .get("$BASE_URL_TWO/CoopsPrices/GetItemDetailsByBarcode/$itemBarcode");

    if (getItemDetailsByBarcodeModelResponse.statusCode == 200) {
      print(getItemDetailsByBarcodeModelResponse.body);
      return getItemDetailsByBarcodeModelFromJson(
          getItemDetailsByBarcodeModelResponse.body);
    } else if (getItemDetailsByBarcodeModelResponse.statusCode == 404) {
      print(getItemDetailsByBarcodeModelResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
