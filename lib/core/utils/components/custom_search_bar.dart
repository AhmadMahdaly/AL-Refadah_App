import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    required this.controller,
    required this.clearIcon,
    super.key,
  });
  final TextEditingController controller;
  final Widget clearIcon;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 15.sp,
        color: const Color(0xFF494949),
        fontWeight: FontWeight.w300,
        fontFamily: 'FF Shamel Family',
      ),
      cursorWidth: 1.sp,
      cursorColor: kMainColor,
      minLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'ابحث هنا',
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFFA2A2A2),
          fontWeight: FontWeight.w300,
        ),
        suffixIcon: widget.controller.text.isNotEmpty ? widget.clearIcon : null,
        border: textfieldBorderRadius(const Color(0xFFD6D6D6)),
        focusedBorder: textfieldBorderRadius(kMainColor),
        enabledBorder: textfieldBorderRadius(const Color(0xFFD6D6D6)),
        focusedErrorBorder: textfieldBorderRadius(Colors.red),
        prefixIcon: SvgPicture.asset(
          'assets/svg/search.svg',
          fit: BoxFit.none,
          colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
