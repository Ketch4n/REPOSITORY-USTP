String projectCollectionBinaryValue(int type) {
  switch (type) {
    case 0:
      return "COLLECTION";
    case 1:
      return "MANUSCRIPT";
    case 2:
      return "POSTER";
    case 3:
      return "VIDEO";
    case 4:
      return "SOURCE CODE";
    default:
      return "INVALID PROJECT KEYWORD";
  }
}
