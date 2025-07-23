import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateAiMusic({
  required String id,
  required String title,
  required String description,
  required String genre,
  required String status,
  required String duration,
  required List<String> metadata,
  required String type,
  required String mood,
  required String tempo,
  required String filePath,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final uri = Uri.parse('${ApiConstants.baseUrl}/ai/music/creation/$id');

  final request = http.MultipartRequest('POST', uri);
  request.headers.addAll({
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  request.fields.addAll({
    'title': title,
    'description': description,
    'genre': genre,
    'status': status,
    'duration': duration,
    'metadata[]': metadata.toString(),
    'type': type,
    'mood': mood,
    'tempo': tempo,
  });

  request.files.add(await http.MultipartFile.fromPath('file_path', filePath));

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);
      print('✅ AI Music Updated: ${decoded['message']}');
    } else {
      print('❌ Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}
