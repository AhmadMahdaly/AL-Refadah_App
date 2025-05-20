import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  const CustomTextFieldWithLabel({
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
    this.textDirection,
    this.fontSize = 15,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.readOnly = false,
    this.fontWeight = FontWeight.w300,
    this.focusNode,
    this.onTap,
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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      focusNode: focusNode,
      readOnly: readOnly,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: fontSize!.sp,
        color: enabled ? const Color(0xFF494949) : const Color(0xFFA2A2A2),
        fontWeight: fontWeight,
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
        counter: const SizedBox.shrink(),
        contentPadding: contentPadding,
        labelText: text,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFFA2A2A2),
          fontWeight: FontWeight.w300,
        ),
        suffixIcon: passwordIcon,
        prefixIcon: icon,
        border:
            enabled
                ? textfieldBorderRadius(kMainColorLightColor)
                : textfieldBorderRadius(kMainExtrimeLightColor),
        focusedBorder: textfieldBorderRadius(kMainColor),
        enabledBorder:
            enabled
                ? textfieldBorderRadius(kMainColorLightColor)
                : textfieldBorderRadius(kMainExtrimeLightColor),
        focusedErrorBorder: textfieldBorderRadius(Colors.red),
      ),
    );
  }
}
