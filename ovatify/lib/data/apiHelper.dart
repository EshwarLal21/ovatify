

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'apiConstants.dart';
import 'package:http_parser/http_parser.dart';


class ApiService {
  static Future<http.Response> post(String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    return await http.post(
      url,
      headers: headers ??
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
      body: json.encode(body),
    );
  }

  static Future<http.Response> get(String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint')
        .replace(queryParameters: queryParams);
    return await http.get(url, headers: headers);
  }

  static Future<http.Response> getAllJobs(String? token) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/job');
    return await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }


  static Future<http.StreamedResponse> uploadTrack({
    required File file,
    required String title,
    required String description,
    required String genre,
    required String status,
    required String duration,
    required List<String> metadata,
  }) async {
    var uri = Uri.parse('${ApiConstants.baseUrl}/creation');
    var request = http.MultipartRequest('POST', uri);

    request.fields.addAll({
      'title': title,
      'description': description,
      'genre': genre,
      'status': status,
      'duration': duration,
      'metadata[]': metadata.join(','),
    });

    request.files.add(await http.MultipartFile.fromPath(
      'music_file',
      file.path,
      contentType: MediaType('audio', 'mpeg'),
    ));

    request.headers.addAll({
      'Accept': 'application/json',
    });

    return await request.send();
  }

  Future<List<dynamic>> fetchAllTracks() async {
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/music/creation?page=1'));
    print(response.statusCode);
    print(response);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data']; // adjust based on your API response
    } else {
      throw Exception('Failed to load tracks');
    }
  }

// For Track by ID
  Future<Map<String, dynamic>> fetchTrackById(String id) async {
    final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/music/creation/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load track by ID');
    }
  }

  static Future<Map<String, dynamic>?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("No token found.");
      return null;
    }

    final response = await http.get(
      Uri.parse(ApiConstants.getProfile),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Failed to fetch profile: ${response.statusCode}");
      return null;
    }
  }


}
