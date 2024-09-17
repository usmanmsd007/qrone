import 'package:flutter/material.dart';

// extension on BuildContext{

// }
extension ABC on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get halfWidth => MediaQuery.of(this).size.width / 2;
  double get halfHeight => MediaQuery.of(this).size.height / 2;
}
