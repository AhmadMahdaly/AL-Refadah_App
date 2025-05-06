import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class H extends StatelessWidget {
  const H({required this.h, super.key});
  final double h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: h.h);
  }
}

class W extends StatelessWidget {
  const W({required this.w, super.key});
  final double w;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w);
  }
}
