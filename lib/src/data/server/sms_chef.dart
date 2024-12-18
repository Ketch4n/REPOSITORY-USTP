import 'dart:convert';
import 'package:http/http.dart' as http;

class SMSChefService {
  final String apiUrl = "https://www.cloud.smschef.com/api/send/sms.bulk";
  final String apiSecret =
      "3638a9d8e146bd29dc1d97e2394d7b43bd68a675"; // Replace with your API secret
  final String deviceId =
      "00000000-0000-0000-ede9-acc286e2fe04"; // Replace with your device ID

  Future<Map<String, dynamic>> sendSMS(
      List<String> numbers, String message) async {
    try {
      // Prepare the payload
      final payload = {
        "secret": apiSecret,
        "mode": "devices",
        "numbers": numbers
            .join(","), // Convert list of numbers to comma-separated string
        "device": deviceId,
        "sim": 1.toString(),
        "priority": 1.toString(),
        "message": message,
      };

      // Send POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: payload,
      );

      // Decode the response
      if (response.statusCode == 200) {
        return json.decode(response.body); // Successful response
      } else {
        return {
          "error": "Failed to send SMS",
          "status": response.statusCode,
          "body": response.body,
        };
      }
    } catch (e) {
      return {"error": "An error occurred", "details": e.toString()};
    }
  }
}
