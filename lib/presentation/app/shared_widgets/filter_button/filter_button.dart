import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/presentation/app/shared_widgets/filter_button/widgets/custom_filter_show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// A button widget that opens a filter modal bottom sheet.
/// The button has a consistent style with the SortButton and is positioned
/// on the left side of the screen.
class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  static const double _buttonWidth = 125;
  static const double _buttonHeight = 56;
  static const double _iconSize = 24;
  static const double _textSize = 14;
  static const double _borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showFilterModal(context),
      child: _buildButtonContainer(),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet<void>(
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: kScaffoldBackgroundColor,
      context: context,
      builder: (context) => const CustomFilterShowModalBottomSheet(),
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
          topLeft: Radius.circular(_borderRadius.r),
          bottomLeft: Radius.circular(_borderRadius.r),
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
        SvgPicture.asset('assets/svg/filter.svg', height: _iconSize.h),
        Text(
          'تصفية',
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
