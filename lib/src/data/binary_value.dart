// SYSTEM USER BINARY VALUE
import 'package:flutter/material.dart';

String userBinaryValue(int type) {
  if (type == 0) {
    const value = "Administrator";
    return value;
  } else if (type == 1) {
    const value = "Instructor";
    return value;
  } else if (type == 2) {
    const value = "Student";
    return value;
  } else {
    const value = "Invalid User type";
    return value;
  }
}

String projectTypeBinaryValue(int type) {
  switch (type) {
    case 0:
      return "RECENTLY ADDED";
    case 1:
      return "IOT CAPSTONE";
    case 2:
      return "WEB APP CAPSTONE";
    case 3:
      return "PIT PROJECT";
    default:
      return "INVALID PROJECT TYPE";
  }
}

Icon projectPrivacyValue(int value) {
  switch (value) {
    case 0:
      return const Icon(
        Icons.public,
        color: Colors.blue,
      );
    case 1:
      return const Icon(
        Icons.security,
        color: Colors.orange,
      );
    default:
      return const Icon(Icons.no_accounts);
  }
}
