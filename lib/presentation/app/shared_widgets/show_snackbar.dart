import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(child: Text(message)), backgroundColor: color),
  );
}
