import 'package:alrefadah/core/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      color: kScaffoldBackgroundColor,
      iconTheme: IconThemeData(color: kMainColor),
    ),
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    textTheme: Theme.of(context).textTheme.apply(fontFamily: 'GE SS Two'),
  );
}
