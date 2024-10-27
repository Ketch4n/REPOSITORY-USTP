String projectKeywordBinaryValue(int type) {
  switch (type) {
    case 0:
      return "KEYWORD";
    case 1:
      return "TITLE";
    case 2:
      return "AUTHOR";
    case 3:
      return "YEAR PUBLISHED";
    case 4:
      return "SEMESTER";
    default:
      return "INVALID PROJECT KEYWORD";
  }
}
