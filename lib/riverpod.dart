import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/utils.dart';

import 'model/calculator.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, Calculator>(
        (ref) => CalculatorNotifier());

class CalculatorNotifier extends StateNotifier<Calculator> {
  CalculatorNotifier() : super(const Calculator());

  void append(String buttonText) {
    var equation = state.equation;
    if (Utils.isOperator(buttonText) && Utils.isOperatorAtEnd(state.equation)) {
      // replace last typed operator
      equation = equation.substring(0, equation.length - 1) + buttonText;
    } else {
      equation = equation == '0'
          ? Utils.isOperator(buttonText)
              ? '0'
              : buttonText
          : equation + buttonText;
    }
    state = state.copyWith(equation: equation);
  }
}
