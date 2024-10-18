String projectTypeBinaryValue(int type) {
  switch (type) {
    case 0:
      return "PROJECT TYPE";
    case 1:
      return "IOT CAPSTONE";
    case 2:
      return "WEB APP CAPSTONE";
    case 3:
      return "PIT PROJECT";
    case 4:
      return "ALL PROJECT";
    default:
      return "INVALID PROJECT TYPE";
  }
}
