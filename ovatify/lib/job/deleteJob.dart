import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteJob(String jobId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
String? token = prefs.getString('token');

  final url = Uri.parse('${ApiConstants.baseUrl}/job/$jobId');
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = json.encode({
    "title": "Laravel Advanced Course",
    "price": 149.99,
    "description": "This course covers advanced topics in Laravel including packages, events, and queues.",
    "requirements": "Basic knowledge of PHP and Laravel framework.",
    "tags": ["laravel", "php", "backend"]
  });

  try {
    final request = http.Request('DELETE', url)
      ..headers.addAll(headers)
      ..body = body;

    final response = await request.send();

    if (response.statusCode == 200) {
      final resBody = await response.stream.bytesToString();
      final decoded = json.decode(resBody);

      if (decoded['success'] == true) {
        print("✅ Job Deleted: ${decoded['message']}");
        Get.snackbar('Deleted', decoded['message']);
      } else {
        print("❌ Deletion failed: ${decoded['message']}");
        Get.snackbar('Error', decoded['message']);
      }
    } else {
      print("❌ HTTP ${response.statusCode} - ${response.reasonPhrase}");
      Get.snackbar('Error', 'Failed to delete job');
    }
  } catch (e) {
    print("❌ Exception: $e");
    Get.snackbar('Error', 'Something went wrong while deleting');
  }
}
