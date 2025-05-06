import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/presentation/app/shared_widgets/sort_button/widgets/custom_sort_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// A button widget that opens a sort modal bottom sheet.
/// The button has a consistent style with the FilterButton and is positioned
/// on the right side of the screen.
class SortButton extends StatelessWidget {
  const SortButton({super.key});

  static const double _buttonWidth = 125;
  static const double _buttonHeight = 56;
  static const double _iconSize = 24;
  static const double _textSize = 14;
  static const double _borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showSortModal(context),
      child: _buildButtonContainer(),
    );
  }

  void _showSortModal(BuildContext context) {
    showModalBottomSheet<void>(
      clipBehavior: Clip.antiAlias,
      useSafeArea: true,
      backgroundColor: kScaffoldBackgroundColor,
      context: context,
      builder: (context) => const CustomSortShowModalBottomSheet(),
    );
  }

  Widget _buildButtonContainer() {
    return Container(
      width: _buttonWidth.w,
      height: _buttonHeight.h,
      decoration: BoxDecoration(
        color: kMainColor,
        border: Border.all(color: kMainColorLightColor, width: 0.5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(_borderRadius.r),
          bottomRight: Radius.circular(_borderRadius.r),
        ),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      spacing: 8.w,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svg/sort.svg', height: _iconSize.h),
        Text(
          'ترتيب',
          style: TextStyle(
            color: kScaffoldBackgroundColor,
            fontSize: _textSize.sp,
            fontWeight: FontWeight.w500,
            height: 1.43.h,
          ),
        ),
      ],
    );
  }
}
