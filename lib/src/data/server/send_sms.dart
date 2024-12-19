import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';

Future<Map<String, dynamic>> sendSmsToLaravel({
  required String phone,
  required String message,
}) async {
  // Laravel backend API URL
  String apiUrl = '${Servername.host}send-sms';

  try {
    // Prepare request body
    final Map<String, dynamic> requestBody = {
      'phone': phone,
      'message': message,
    };

    // Send POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(requestBody),
    );

    // Check response status
    if (response.statusCode == 200) {
      // Parse JSON response
      return json.decode(response.body);
    } else {
      // Handle non-200 responses
      return {
        'success': false,
        'status': response.statusCode,
        'message': 'Error: ${response.body}',
      };
    }
  } catch (e) {
    // Handle exceptions
    return {
      'success': false,
      'message': 'Exception: $e',
    };
  }
}
