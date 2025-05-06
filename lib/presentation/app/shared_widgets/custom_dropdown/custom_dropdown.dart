import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStringDropdown extends StatelessWidget {
  const CustomStringDropdown({
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    super.key,
  });
  final Widget hint;
  final List<DropdownMenuItem<String>>? items;
  final String value;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      padding: EdgeInsets.zero,
      isExpanded: true,
      dropdownColor: kScaffoldBackgroundColor,
      hint: hint,
      decoration: InputDecoration(
        border: dropdownBorderRadius(kMainColorLightColor),
        focusedBorder: dropdownBorderRadius(kMainColorLightColor),
        enabledBorder: dropdownBorderRadius(kMainColorLightColor),
        focusedErrorBorder: dropdownBorderRadius(kErrorColor),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: kMainColor),
      style: TextStyle(
        color: kMainColor,
        fontSize: 15.sp,
        fontFamily: 'GE SS Two',
        fontWeight: FontWeight.w300,
        height: 1.43.h,
      ),
      items: items,
      value: value,
      onChanged: onChanged,
    );
  }
}
