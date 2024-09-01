// SYSTEM USER BINARY VALUE
class UserBinary {
  static int defaultValue = 3;
  static String username = "Undefined User";
  static String email = "email.undefined@gmail.com";
}

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
  if (type == 0) {
    const value = "RECENTLY ADDED";

    return value;
  } else if (type == 1) {
    const value = "IOT CAPSTONE";

    return value;
  } else if (type == 2) {
    const value = "WEB APP CAPSTONE";

    return value;
  } else if (type == 3) {
    const value = "PIT PROJECT";
    return value;
  } else {
    const value = "INVALID PROJECT TYPE";
    return value;
  }
}
