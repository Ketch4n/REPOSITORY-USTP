String projectTypeBinaryValue(int type) {
  switch (type) {
    case 0:
      return "ALL";
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
