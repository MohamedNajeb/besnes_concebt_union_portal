import 'package:unionportal/models/models.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

abstract class MembersRepository {
  Future<AllWorkMembersModel> getAllWorkMembers();
  Future<SingleWorkMemberModel> getSingleWorkMember(String lang, int workerID);
}

class MembersRepositoryImpl extends MembersRepository {
  http.Response allWorkMembersResponse;
  http.Response singleWorkMemberResponse;

  @override
  Future<AllWorkMembersModel> getAllWorkMembers() async {
    allWorkMembersResponse = await http.get("$root/Editors");

    if (allWorkMembersResponse.statusCode == 200) {
      print(allWorkMembersResponse.body);
      return allWorkMembersModelFromJson(allWorkMembersResponse.body);
    } else if (allWorkMembersResponse.statusCode == 404) {
      print(allWorkMembersResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<SingleWorkMemberModel> getSingleWorkMember(
      String lang, int workerID) async {
    singleWorkMemberResponse = await http.get("$root/Editor/$workerID?lang=ar");

    if (singleWorkMemberResponse.statusCode == 200) {
      print(singleWorkMemberResponse.body);
      return singleWorkMemberModelFromJson(singleWorkMemberResponse.body);
    } else if (singleWorkMemberResponse.statusCode == 404) {
      print(singleWorkMemberResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
