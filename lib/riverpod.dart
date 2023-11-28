import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';
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

  void equals() {
    calculate();
  }

  void calculate() {
    final expression = state.equation.replaceAll('⨯', '*').replaceAll('÷', '/');
    try {
      final exp = Parser().parse(expression);
      final model = ContextModel();

      final result = '${exp.evaluate(EvaluationType.REAL, model)}';

      state = state.copyWith(result: result);
    } catch (e) {}
  }

  void delete() {
    final equation = state.equation.substring(0, state.equation.length - 1);

    if (equation.isEmpty) {
      reset();
    } else {
      state = state.copyWith(
        equation: equation,
      );
    }

    calculate();
  }

  void reset() {
    state = state.copyWith(equation: '0', result: '0');
  }
}
