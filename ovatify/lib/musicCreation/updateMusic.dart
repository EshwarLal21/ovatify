import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateMusicTrack({
  required String id,
  required String title,
  required String description,
  required String genre,
  required String status,
  required String duration,
  required List<String> metadata,
  required String musicFilePath,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  var uri = Uri.parse('${ApiConstants.baseUrl}/music/creation/$id'); // Replace with your base URL
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  var request = http.MultipartRequest('POST', uri);
  request.fields.addAll({
    'title': title,
    'description': description,
    'genre': genre,
    'status': status,
    'duration': duration,
    'metadata[]': metadata.toString(),
  });

  if (musicFilePath.isNotEmpty) {
    request.files.add(await http.MultipartFile.fromPath('music_file', musicFilePath));
  }

  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      final decoded = jsonDecode(result);
      if (decoded['success'] == true) {
        print("✅ Track updated successfully: ${decoded['data']}");
        Get.snackbar('Success', 'Track updated successfully!');
        // fetchTracks();
      } else {
        print("❌ Update failed: ${decoded['message']}");
        Get.snackbar('Error', decoded['message']);
      }
    } else {
      print("❌ HTTP Error ${response.statusCode}: ${response.reasonPhrase}");
      Get.snackbar('Error', 'HTTP Error: ${response.statusCode}');
    }
  } catch (e) {
    print("❌ Exception during update: $e");
    Get.snackbar('Error', 'Something went wrong');
  }
}
