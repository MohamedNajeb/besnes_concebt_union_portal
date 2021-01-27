import 'package:unionportal/models/models.dart';
import 'package:http/http.dart' as http;

abstract class BarcodeDetailsRepository {
  Future<List<BarcodeModel>> getBarcodeItem(String barcode);
}

class BarcodeDetailsRepositoryImpl extends BarcodeDetailsRepository {
  http.Response barCodeResponse;

  @override
  Future<List<BarcodeModel>> getBarcodeItem(String barcode) async {
    barCodeResponse = await http
        .get("https://intapi.cooopnet.com/api/v1/items/getbybarcode/$barcode");

    if (barCodeResponse.statusCode == 200) {
      print(barCodeResponse.body);
      return barcodeModelFromJson(barCodeResponse.body);
    } else if (barCodeResponse.statusCode == 404) {
      print(barCodeResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
