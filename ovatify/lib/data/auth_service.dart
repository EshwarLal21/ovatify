import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ovatify/data/apiConstants.dart';

class AuthService {
  static Future<String?> resendEmail({required String email}) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.resend}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({"email": email}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["message"];
      } else {
        final error = json.decode(response.body);
        return error["message"] ?? "Something went wrong";
      }
    } catch (e) {
      return "Network error: $e";
    }
  }
}
