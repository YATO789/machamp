extension StringExtension on String {
  String toSnakeCase() {
    final buffer = StringBuffer();
    for (var i = 0; i < length; i++) {
      final char = this[i];
      if (i > 0 && char.toUpperCase() == char && char.toLowerCase() != char) {
        buffer.write('_');
      }
      buffer.write(char.toLowerCase());
    }
    return buffer.toString();
  }
}
