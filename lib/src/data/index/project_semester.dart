String projectSemesterBinaryValue(int type) {
  switch (type) {
    case 1:
      return "1st Sem";
    case 2:
      return "2nd Sem";
    case 3:
      return "Mid-Year";

    default:
      return "N/A";
  }
}
