extension NumberFormater on num {
  String organizedNumber() {
    if (this >= 1000000) {
      double value = this / 1000000;
      return "${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}Mn";
    }
    if (this >= 1000) {
      double value = this / 1000;
      return "${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}B";
    }
    return toString();
  }
}
