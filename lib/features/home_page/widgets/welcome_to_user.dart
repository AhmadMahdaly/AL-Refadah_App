import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeToUser extends StatefulWidget {
  const WelcomeToUser({super.key});

  @override
  State<WelcomeToUser> createState() => _WelcomeToUserState();
}

class _WelcomeToUserState extends State<WelcomeToUser> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    fUserName = await CacheHelper.getData(key: 'fUserName');
    if (mounted) {
      setState(() {});
    }
  }

  String? fUserName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(320.r),
          ),
          child: const Icon(Icons.person, color: kMainColor),
        ),
        W(w: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أهلا بك',
              style: TextStyle(
                color: kMainColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.23.h,
              ),
            ),
            const H(h: 6),
            SizedBox(
              height: 16.h,
              child: Text(
                fUserName ?? '',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.14.h,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Image.asset('assets/images/logo.png', width: 46, height: 32),
      ],
    );
  }
}
