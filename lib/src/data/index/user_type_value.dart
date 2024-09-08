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
