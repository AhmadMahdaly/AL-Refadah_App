import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoNetworkDialog extends StatelessWidget {
  const NoNetworkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // تأجيل استدعاء showDialog بعد اكتمال مرحلة البناء
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              spacing: 5.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_off_rounded, size: 84.w),
                Text(
                  'للأسف',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'هناك مشكلة في الحصول على البيانات. تحقق من اتصالك بالإنترنت',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const Text(
                      'حاول مرة أخرى',
                      style: TextStyle(color: kMainExtrimeLightColor),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });

    // بناء الـ Scaffold بشكل طبيعي
    return Scaffold(
      body: FutureBuilder<String?>(
        future: Future.value(null), // مجرد استدعاء لتجنب أخطاء البناء
        builder: (context, snapshot) => const SizedBox(),
      ),
    );
  }
}
