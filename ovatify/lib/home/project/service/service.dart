import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ovatify/data/apiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model.dart';

class ProjectService {

  static Future<List<Project>> fetchProjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
print(token);
    var response = await http.get(Uri.parse('https://ovatify.betfastwallet.com/api/user/projects'), headers: headers);
print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> recentProjects = jsonData['data']['recent_projects'];
      print(token);
      print(response.statusCode);
      return recentProjects.map((e) => Project.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<void> fetchProjectDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print("No token found in SharedPreferences");
        return;
      }

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };


      final uri = Uri.parse(
        '${ApiConstants.baseUrl}/project/details/3/normal%20or%20ai',
      );

      var request = http.Request('GET', uri);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        print("Project details: $data");
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }




}
