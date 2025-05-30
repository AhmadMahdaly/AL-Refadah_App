import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/presentation/app/shared_cubit/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingLocation extends StatelessWidget {
  const LoadingLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.location_off_rounded, size: 80.sp, color: kMainColor),
          20.verticalSpace,
          SizedBox(
            width: 375.w,
            child: Text(
              'يجب عليك تحميل الموقع لإضافة الرحلة',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: kMainColor),
            ),
          ),
          40.verticalSpace,
          CustomButton(
            text: 'تحميل الموقع',
            onTap: () {
              context.read<GetCurrentLocationCubit>().getCurrentLocation();
            },
          ),
        ],
      ),
    );
  }
}
