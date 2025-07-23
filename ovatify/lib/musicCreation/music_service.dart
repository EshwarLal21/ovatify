import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class MusicService {
  static Future<void> uploadMusic({
    required File musicFile,
    required String title,
    required String description,
    required String genre,
    required String status,
    required String duration,
    required List<String> metadata,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) throw Exception('User not logged in');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://ovatify.betfastwallet.com/api/user/music/creation'),
        //https://ovatify.betfastwallet.com/api/user
    );

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['genre'] = genre;
    request.fields['status'] = status;
    request.fields['duration'] = duration;

    for (var tag in metadata) {
      request.fields['metadata[]'] = tag;
    }

    request.files.add(await http.MultipartFile.fromPath(
      'music_file',
      musicFile.path,
      filename: basename(musicFile.path),
    ));

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("✅ Upload Success: ${await response.stream.bytesToString()}");
    } else {
      print("❌ Upload Failed: ${response.statusCode}");
    }
  }
}
