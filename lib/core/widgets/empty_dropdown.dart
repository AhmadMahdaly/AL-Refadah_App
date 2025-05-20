import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EmptyDropdown extends StatelessWidget {
  const EmptyDropdown({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        dropdownColor: kScaffoldBackgroundColor,
        hint: Row(
          children: [
            SvgPicture.asset(
              'assets/svg/kaaba 1.svg',
              height: 16.h,
              colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
            ),
            SizedBox(width: 6.w),
            Text(
              title,
              style: TextStyle(
                color: kMainColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.25.h,
              ),
            ),
          ],
        ),
        decoration: InputDecoration(
          border: dropdownBorderRadius(kMainColorLightColor),
          focusedBorder: dropdownBorderRadius(kMainColorLightColor),
          enabledBorder: dropdownBorderRadius(kMainColorLightColor),
          focusedErrorBorder: dropdownBorderRadius(Colors.red),
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: kMainColor),
        style: TextStyle(
          color: kMainColor,
          fontSize: 15.sp,
          fontFamily: 'GE SS Two',
          fontWeight: FontWeight.w300,
        ),
        items: const [],
        value: null,
        onChanged: null,
      ),
    );
  }
}
