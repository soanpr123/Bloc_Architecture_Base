bool checkFormat(String regex, String checkedString) {
  return RegExp(regex).hasMatch(checkedString);
}
