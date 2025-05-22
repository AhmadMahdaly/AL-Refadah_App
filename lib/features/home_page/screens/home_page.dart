import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/date_and_time_cubit/date_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/date_and_time_cubit/time_cubit.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/widgets/date_and_time.dart';
import 'package:alrefadah/features/home_page/widgets/home_body.dart';
import 'package:alrefadah/features/home_page/widgets/welcome_to_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimeCubit>(create: (context) => TimeCubit()),
        BlocProvider<DateCubit>(create: (context) => DateCubit()),
      ],
      child: RefreshIndicator(
        strokeWidth: 0.9,
        color: kMainColor,
        onRefresh: () => context.read<HomeCubit>().getDashboardData(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60.h),
              child: Column(
                spacing: 14.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// welcome user
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: const WelcomeToUser(),
                  ),

                  /// Date and time
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: const DateAndTime(),
                  ),
                  const H(h: 2),
                ],
              ),
            ),
          ),

          /// Body
          body: const HomeBody(),
        ),
      ),
    );
  }
}
