class Utils {
  static bool isOperator(String buttonText, {bool hasEquals = false}) {
    final operators = [
      '+',
      '-',
      '÷',
      '⨯',
      '.',
      if (hasEquals) ...['=']
    ];

    return operators.contains(buttonText);
  }
}
