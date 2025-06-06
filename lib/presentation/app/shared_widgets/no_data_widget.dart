import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'هناك خطأ في تحميل البيانات',
            textAlign: TextAlign.center,
            maxLines: 5,
            style: TextStyle(
              color: kDartTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          H(h: 10.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kMainColor),
            onPressed: onPressed,
            child: const Text(
              'حاول مرة أخرى',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
