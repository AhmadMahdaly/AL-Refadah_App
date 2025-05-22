import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmCardLoginNumberWidget extends StatefulWidget {
  const ConfirmCardLoginNumberWidget({super.key});

  @override
  State<ConfirmCardLoginNumberWidget> createState() =>
      _ConfirmCardLoginNumberWidgetState();
}

class _ConfirmCardLoginNumberWidgetState
    extends State<ConfirmCardLoginNumberWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    phoneNo = await CacheHelper.getData(key: 'phoneNo');
    if (mounted) {
      setState(() {});
    }
  }

  String? phoneNo;
  String maskExceptLast4(String phoneNo) {
    if (phoneNo.length <= 4) return phoneNo;
    final last4 = phoneNo.substring(phoneNo.length - 4);
    return '*' * (phoneNo.length - 4) + last4;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309.w,
      height: 62.h,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50.w, color: const Color(0xFFF3E7FF)),

          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'تم إرسال رمز التحقق إلى:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF494949),
              fontSize: 13.sp,
              fontWeight: FontWeight.w300,
              height: 1.54.h,
            ),
          ),
          W(w: 10.w),
          Text(
            maskExceptLast4(phoneNo ?? ''),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kTextColor,
              fontSize: 13.sp,
              fontFamily: 'FF Shamel Family',
              fontWeight: FontWeight.w300,
              height: 1.54.h,
            ),
          ),
        ],
      ),
    );
  }
}
