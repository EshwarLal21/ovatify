import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ovatify/data/apiConstants.dart';
import '../home/project/model/job_detail_model.dart';

class JobDetailService {
  static Future<JobDetailModel> fetchJobDetail(int jobId, String token) async {
    var url = Uri.parse('${ApiConstants.baseUrl}/job/detail/$jobId');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return JobDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load job detail');
    }
  }
}
