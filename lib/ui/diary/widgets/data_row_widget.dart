import 'package:flutter/material.dart';
import 'package:health_diary/domain/diary/diary.dart';

class DataRowWidget extends StatelessWidget {
  final DateTime enteredDateTime;
  final Fraction fraction;
  final String unit;

  const DataRowWidget({
    Key? key,
    required this.enteredDateTime,
    required this.fraction,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DataRowText(
            '${enteredDateTime.day}.${enteredDateTime.month}.${enteredDateTime.year}  ${enteredDateTime.hour}:${enteredDateTime.minute}'),
        DataRowText(
            '${_formatNumber(fraction.numerator)}${fraction.denominator != null ? '/${_formatNumber(fraction.denominator!)}' : ''} $unit'),
      ],
    );
  }
}

class DataRowText extends StatelessWidget {
  final String data;

  const DataRowText(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

dynamic _formatNumber(double number) {
  if (number.compareTo(number.truncate()) != 0) {
    return number;
  } else {
    return number.truncate();
  }
}
