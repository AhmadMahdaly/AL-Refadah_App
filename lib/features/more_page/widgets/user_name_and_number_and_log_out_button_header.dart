import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';
import 'package:alrefadah/features/auth/screans/login_screen.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    userId = await CacheHelper.getData(key: 'userId');
    phoneNo = await CacheHelper.getData(key: 'phoneNo');
    if (mounted) {
      setState(() {});
    }
  }

  String? phoneNo;
  String? userId;
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
          child: Image.asset('assets/images/user.jpg', fit: BoxFit.cover),
        ),
        W(w: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
              child: Text(
                phoneNo ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.14.h,
                ),
              ),
            ),
            const H(h: 8),
            SizedBox(
              height: 16.h,
              child: Text(
                userId ?? '',
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
        InkWell(
          onTap: () async {
            try {
              await context.read<AuthCubit>().logout();
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
