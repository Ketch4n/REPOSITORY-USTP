String projectKeywordBinaryValue(int type) {
  switch (type) {
    case 0:
      return "ALL";
    case 1:
      return "TITLE";
    case 2:
      return "AUTHOR";
    case 3:
      return "YEAR PUBLISHED";
    default:
      return "INVALID PROJECT KEYWORD";
  }
}
