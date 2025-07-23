// ✅ COMPLETE SCREEN: AI Music Listing Page (with fetchAiMusic)
// Place this as a new screen: `AiMusicListScreen.dart`

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/appColor.dart';
import '../data/apiConstants.dart';

class AiMusicListScreen extends StatefulWidget {
  const AiMusicListScreen({Key? key}) : super(key: key);

  @override
  State<AiMusicListScreen> createState() => _AiMusicListScreenState();
}

class _AiMusicListScreenState extends State<AiMusicListScreen> {
  List<dynamic> aiTracks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAiMusic();
  }

  Future<void> fetchAiMusic() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Uri url = Uri.parse('${ApiConstants.baseUrl}/ai/music/creation?page=1');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      setState(() {
        aiTracks = decoded['ai_musics'];
        isLoading = false;
      });
    } else {
      print('Error: ${response.reasonPhrase}');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text("My AI Tracks"),
        backgroundColor: AppColors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchAiMusic,
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: aiTracks.length,
              itemBuilder: (context, index) {
                final track = aiTracks[index];
                return ListTile(
                  title: Text(track['title'] ?? 'No Title', style: TextStyle(color: Colors.white)),
                  subtitle: Text(track['description'] ?? '', style: TextStyle(color: Colors.grey)),
                  trailing: Icon(Icons.music_note, color: AppColors.primary),
                );
              },
            ),
    );
  }
}



