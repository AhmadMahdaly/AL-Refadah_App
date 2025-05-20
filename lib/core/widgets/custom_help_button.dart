import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomHelpButton extends StatelessWidget {
  const CustomHelpButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: SvgPicture.asset(
        'assets/svg/help_circle_outline.svg',
        colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
      ),
    );
  }
}
