import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../data/apiHelper.dart';

Future<void> purchaseTrack() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token'); 

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = {
    "name": "John Doe",
    "card_no": "4111111111111111",
    "expiry": "12/26",
    "cvv": "123",
    "track_id": 1
  };

  final response = await ApiService.post('/purchase/track', body: body, headers: headers);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['success'] == true) {
      print("✅ Purchase successful: ${data['message']}");
    } else {
      print("❌ Failed: ${data['message']}");
    }
  } else {
    print("❌ Error ${response.statusCode}: ${response.reasonPhrase}");
  }
}
