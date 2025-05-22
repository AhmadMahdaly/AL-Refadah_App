import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/home_page/cubit/date_and_time_cubit/date_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/date_and_time_cubit/time_cubit.dart';

class DateAndTime extends StatelessWidget {
  const DateAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateCubit, String>(
      builder: (context, date) {
        return BlocBuilder<TimeCubit, String>(
          builder: (context, time) {
            return Row(
              spacing: 6.w,
              children: [
                Icon(Icons.sunny, color: kMainColor, size: 18.sp),
                Text(
                  date,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    height: 1.23.h,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.watch_later_outlined,
                  color: kMainColor,
                  size: 18.sp,
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    height: 1.23.h,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
