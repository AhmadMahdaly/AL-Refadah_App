import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNameAndNumberAndLogOutButtonHeader extends StatefulWidget {
  const UserNameAndNumberAndLogOutButtonHeader({super.key});

  @override
  State<UserNameAndNumberAndLogOutButtonHeader> createState() =>
      _UserNameAndNumberAndLogOutButtonHeaderState();
}

class _UserNameAndNumberAndLogOutButtonHeaderState
    extends State<UserNameAndNumberAndLogOutButtonHeader> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    fPermName = await CacheHelper.getData(key: 'fPermName');
    fUserName = await CacheHelper.getData(key: 'fUserName');

    if (mounted) {
      setState(() {});
    }
  }

  String? fPermName;
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

          /// Person Icon
          child: const Icon(Icons.person, color: kMainColor),
        ),
        W(w: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// user name
            SizedBox(
              height: 16.h,
              child: Text(
                fUserName ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.14.h,
                ),
              ),
            ),
            const H(h: 8),

            /// permission name
            SizedBox(
              height: 16.h,
              child: Text(
                fPermName ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.14.h,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),

        /// log out button
        InkWell(
          onTap: () async {
            try {
              await CacheHelper.clearAll();
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            } catch (e) {
              showErrorDialog(
                isBack: true,
                context,
                message: 'حدث خطأ في تسجيل الخروج',
              );
            }
          },
          child: Container(
            width: 32.w,
            height: 36.h,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              shadows: const [
                BoxShadow(
                  color: kShadowColor,
                  blurRadius: 20,
                  offset: Offset(4, 8),
                ),
              ],
            ),
            child: const Icon(Icons.power_settings_new_sharp),
          ),
        ),
      ],
    );
  }
}
