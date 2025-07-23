import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchAiMusic() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final Uri url = Uri.parse('${ApiConstants.baseUrl}/ai/music/creation?page=1');
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final decoded = json.decode(response.body);
    print('AI Music Fetched Successfully: ${decoded['ai_musics']}');
  } else {
    print('Error: ${response.reasonPhrase}');
  }
}
