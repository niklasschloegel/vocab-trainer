class DescriptionGenerator {
  static String generate(int count, String label) {
    var descriptionString = "$count $label";
    if (count != 1) descriptionString += "s";
    return descriptionString;
  }
}
