import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/auth/screens/check_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 12.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded, size: 84.w),
          Text(
            'للأسف',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 340.w,
            child: Text(
              'هناك مشكلة في الحصول على البيانات!\nتحقق من اتصالك بالإنترنت',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w300),
            ),
          ),
          const H(h: 24),
          Center(
            child: InkWell(
              onTap: () {
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const CheckAuthScreen()),
                    (route) => false,
                  );
                }
              },

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
      ),
    );
  }
}
