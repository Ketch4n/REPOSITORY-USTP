import 'package:repository_ustp/src/data/server/sms_chef.dart';

void sendSMS() async {
  final smsChefService = SMSChefService();

  List<String> numbers = ["+639614901967", "+639630903296"];
  String message = "Hello, this is a test message from Flutter!";

  final result = await smsChefService.sendSMS(numbers, message);

  if (result.containsKey("error")) {
    print("Error: ${result['error']}");
    if (result.containsKey("details")) {
      print("Details: ${result['details']}");
    }
  } else {
    print("SMS sent successfully: ${result}");
  }
}
