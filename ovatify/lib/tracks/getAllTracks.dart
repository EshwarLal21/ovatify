import 'dart:convert';

import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
Future<void> fetchMyTracks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final uri = Uri.parse('${ApiConstants.baseUrl}/my/tracks');

  final request = http.Request('GET', uri);
  request.headers.addAll({
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  });

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);
      print('✅ Tracks fetched: $decoded');
    } else {
      print('❌ Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
