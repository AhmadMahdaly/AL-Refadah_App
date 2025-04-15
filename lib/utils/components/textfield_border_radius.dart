import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

OutlineInputBorder textfieldBorderRadius(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.sp),
    borderSide: BorderSide(color: color),
  );
}
