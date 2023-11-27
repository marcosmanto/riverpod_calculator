// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Calculator {
  final bool shouldAppend;
  final String equation;
  final String result;

  const Calculator({
    this.shouldAppend = true,
    this.equation = '0',
    this.result = '0',
  });

  Calculator copyWith({
    bool? shouldAppend,
    String? equation,
    String? result,
  }) {
    return Calculator(
      shouldAppend: shouldAppend ?? this.shouldAppend,
      equation: equation ?? this.equation,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shouldAppend': shouldAppend,
      'equation': equation,
      'result': result,
    };
  }

  factory Calculator.fromMap(Map<String, dynamic> map) {
    return Calculator(
      shouldAppend: map['shouldAppend'] as bool,
      equation: map['equation'] as String,
      result: map['result'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Calculator.fromJson(String source) =>
      Calculator.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Calculator(shouldAppend: $shouldAppend, equation: $equation, result: $result)';

  @override
  bool operator ==(covariant Calculator other) {
    if (identical(this, other)) return true;

    return other.shouldAppend == shouldAppend &&
        other.equation == equation &&
        other.result == result;
  }

  @override
  int get hashCode =>
      shouldAppend.hashCode ^ equation.hashCode ^ result.hashCode;
}
