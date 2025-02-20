import 'package:flutter/services.dart';

class MobileNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove non-digit characters
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Prevent input if the length exceeds 9 digits
    if (text.length > 9) {
      return oldValue;
    }

    // Format the text with spaces after the second and fifth digits
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 5) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    // Return formatted text with the correct selection position
    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
