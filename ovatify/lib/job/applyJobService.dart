import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/project/model/applyJobModel.dart';

Future<ApplyJobResponse> applyForJob({
  required int jobId,
  required String name,
  required String role,
  required String coverLetter,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token == null) {
    return ApplyJobResponse(success: false, message: "Unauthorized: Token missing.");
  }

  final url = Uri.parse('${ApiConstants.baseUrl}/apply/job');

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = json.encode({
    "job_id": jobId,
    "name": name,
    "role": role,
    "cover_latter": coverLetter,
  });

  final request = http.Request('POST', url);
  request.headers.addAll(headers);
  request.body = body;

  final response = await request.send();

  if (response.statusCode == 200) {
    final resBody = json.decode(await response.stream.bytesToString());
    return ApplyJobResponse.fromJson(resBody);
  } else {
    return ApplyJobResponse(success: false, message: "Something went wrong.");
  }
}


// use in UI
void applyNow() async {
  final response = await applyForJob(
    jobId: 2,
    name: "John Doe",
    role: "Frontend Developer",
    coverLetter: "I am excited to apply for this position because I am passionate about frontend development.",
  );

  if (response.success) {
    Get.snackbar("Success", response.message);
  } else {
    Get.snackbar("Error", response.message);
  }
}
