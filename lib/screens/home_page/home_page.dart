import 'package:alrefadah/cubit/auth_cubit/auth_cubit.dart';
import 'package:alrefadah/screens/login/login_screen.dart';
import 'package:alrefadah/utils/components/height.dart';
import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              onPressed: () {
                try {
                  BlocProvider.of<AuthCubit>(context).logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                } catch (e) {
                  print(e);
                }
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 30.h,
                width: 160.w,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Image.asset('assets/images/text logo.png'),
                  ],
                ),
              ),
            ),
            const H(h: 20),
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(320.r),
                  ),
                  child: Image.asset(
                    'assets/images/user.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                W(w: 10.w),
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
                    const H(h: 10),
                    Text(
                      'عبدالله محمد',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.14.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
