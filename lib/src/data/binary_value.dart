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
