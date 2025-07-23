import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> createAiMusicTrack({
  required String filePath,
}) async {
  var uri = Uri.parse('${ApiConstants.baseUrl}/ai/music/creation');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  var request = http.MultipartRequest('POST', uri);
  request.headers.addAll({
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  });

  request.fields.addAll({
    'title': 'our title',
    'description': 'our description will be here',
    'genre': 'testing genre',
    'status': 'draft',
    'duration': '03:08',
    'metadata[]': '[value1,value2]',
    'type': 'ai',
    'mood': 'ourmood',
    'tempo': 'yes',
  });

  request.files.add(await http.MultipartFile.fromPath('file_path', filePath));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final result = await response.stream.bytesToString();
    print("✅ AI Music Created: $result");
  } else {
    print("❌ Failed: ${response.statusCode} - ${response.reasonPhrase}");
  }
}
