import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InActiveDropdown extends StatelessWidget {
  const InActiveDropdown({
    required this.text,
    required this.value,
    required this.label,
    super.key,
  });
  final String text;
  final int value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      borderRadius: BorderRadius.circular(10.r),
      decoration: InputDecoration(
        fillColor: kScaffoldBackgroundColor,
        filled: true,
        border: textfieldBorderRadius(kMainColorLightColor),
        focusedBorder: textfieldBorderRadius(kMainColorLightColor),
        enabledBorder: textfieldBorderRadius(kMainColorLightColor),
        focusedErrorBorder: textfieldBorderRadius(Colors.red),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: const Color(0xFFA2A2A2),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      style: TextStyle(
        color: kMainColor,
        fontSize: 15.sp,
        fontFamily: 'GE SS Two',
        fontWeight: FontWeight.w300,
        height: 1.43.h,
      ),
      value: value,
      items: [DropdownMenuItem<int>(value: value, child: Text(text))],
      onChanged: null,
    );
  }
}
