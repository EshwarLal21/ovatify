import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteMusicTrack(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final url = Uri.parse('${ApiConstants.baseUrl}/music/creation/$id');
  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded['success'] == true) {
        print("✅ Deleted: ${decoded['message']}");
        Get.snackbar('Deleted', decoded['message']);
        // fetchTracks();
      } else {
        print("❌ Failed: ${decoded['message']}");
        Get.snackbar('Error', decoded['message']);
      }
    } else {
      print("❌ HTTP Error: ${response.statusCode} - ${response.reasonPhrase}");
      Get.snackbar('Error', 'Failed to delete. (${response.statusCode})');
    }
  } catch (e) {
    print("❌ Exception: $e");
    Get.snackbar('Error', 'Something went wrong');
  }
}
