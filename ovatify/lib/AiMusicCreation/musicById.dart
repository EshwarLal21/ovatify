import 'dart:convert';

import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
Future<void> fetchAiMusicById(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final url = Uri.parse('${ApiConstants.baseUrl}/ai/music/creation/$id');

  final request = http.Request('GET', url);
  request.headers.addAll(headers);

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);
      print(response.statusCode);
      if (decoded['success'] == true) {
        print('AI Music by ID: ${decoded['data']}');
      } else {
        print('Failed: ${decoded['message']}');
      }
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}
