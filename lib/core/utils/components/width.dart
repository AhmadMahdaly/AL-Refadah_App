import 'package:flutter/material.dart';

class W extends StatelessWidget {
  const W({required this.w, super.key});
  final double w;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w);
  }
}
