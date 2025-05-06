import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextformfieldWithHint extends StatelessWidget {
  const CustomTextformfieldWithHint({
    this.text,
    this.keyboardType,
    this.obscureText = false,
    super.key,
    this.onChanged,
    this.icon,
    this.validator,
    this.contentPadding,
    this.controller,
    this.maxLines = 1,
    this.inputFormatters,
    this.enabled = true,
    this.textInputAction,
    this.autofillHints,
    this.passwordIcon,
    this.textDirection = TextDirection.ltr,
    this.fontSize = 13,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.readOnly = false,
    this.fontWeight = FontWeight.w300,
    this.focusNode,
    this.onTap,
    this.onFieldSubmitted,
    this.labelText,
  });

  final FocusNode? focusNode;
  final double? fontSize;
  final String? text;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final Widget? icon;
  final Widget? passwordIcon;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool readOnly;
  final int? maxLength;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      onTap: onTap,
      readOnly: readOnly,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: 15.sp,
        color: enabled ? const Color(0xFF494949) : const Color(0xFFA2A2A2),
        fontWeight: fontWeight ?? FontWeight.w300,
        fontFamily: 'FF Shamel Family',
      ),
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      enabled: enabled,
      cursorWidth: 0.81.sp,
      cursorColor: kMainColor,
      minLines: 1,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFFA2A2A2),
          fontWeight: FontWeight.w300,
        ),
        counter: const SizedBox.shrink(),
        contentPadding: contentPadding,
        hintText: text,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFFA2A2A2),
          fontWeight: FontWeight.w300,
        ),
        suffixIcon: passwordIcon,
        prefixIcon: icon,
        border: textfieldBorderRadius(kMainColorLightColor),
        focusedBorder: textfieldBorderRadius(kMainColor),
        enabledBorder: textfieldBorderRadius(kMainColorLightColor),
        focusedErrorBorder: textfieldBorderRadius(kErrorColor),
      ),
    );
  }
}
