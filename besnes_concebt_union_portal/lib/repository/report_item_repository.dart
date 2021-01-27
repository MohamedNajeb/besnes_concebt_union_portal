import 'package:http/http.dart' as http;

abstract class ReportItemRepository {
  Future sendReportInfo(String name, String mobile, String message,
      String imageBytes, var imageExtension);
}

class ReportItemRepositoryImpl extends ReportItemRepository {
  http.Response reportResponse;

  @override
  Future sendReportInfo(String name, String mobile, String message,
      String imageBytes, var imageExtension) async {
    reportResponse =
        await http.post("https://api.cooopnet.com/api/Particibate/Add", body: {
      "Name": name,
      "Mobile": mobile,
      "Message": message,
      "Base64String": imageBytes,
      "Extension": imageExtension,
    });

    if (reportResponse.statusCode == 200) {
      print('>>>>>>>>>>>>>>>>>> 200:' + reportResponse.body);
    } else if (reportResponse.statusCode == 404) {
      print(reportResponse.body);
    } else {
      print("failed to looooooooooooooooad");
      throw Exception('Failed to load post');
    }
  }
}
