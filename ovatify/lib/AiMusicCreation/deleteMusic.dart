import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteAiMusic(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final uri = Uri.parse('${ApiConstants.baseUrl}/ai/music/creation/$id');

  final request = http.Request('DELETE', uri);
  request.headers.addAll({
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);
      print('✅ AI Music Deleted: ${decoded['message']}');
    } else {
      print('❌ Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
